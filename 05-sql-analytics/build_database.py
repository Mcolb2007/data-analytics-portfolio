"""Build a SQLite database from the portfolio's CSV datasets.

The course SQL work was done in a browser-based query environment that does not
export, so this script rebuilds the same kind of relational model locally from the
datasets used elsewhere in this portfolio. Running it makes `queries.sql`
reproducible on any machine with Python installed — no database server needed.

Usage:
    python build_database.py           # creates gca_portfolio.db
"""

from __future__ import annotations

import csv
import sqlite3
from pathlib import Path

DB_PATH = Path(__file__).parent / "gca_portfolio.db"
SCHEMA_PATH = Path(__file__).parent / "schema.sql"
ROOT = Path(__file__).resolve().parent.parent


def rows_from_csv(path: Path, columns: list[str]) -> list[tuple]:
    """Read a CSV and return only the requested columns, blanks and 'NaN' as NULL."""
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        out = []
        for record in reader:
            out.append(tuple(
                None if record[c] in ("", "NA", "NaN", "nan") else record[c]
                for c in columns
            ))
        return out


def load(cursor: sqlite3.Cursor, table: str, csv_path: Path,
         column_map: dict[str, str]) -> None:
    """Load a CSV into `table`, mapping CSV headers to database column names.

    The mapping is explicit because the CSV headers use mixed conventions
    (`ID`, `region`) while the schema uses snake_case throughout.
    """
    csv_columns = list(column_map.keys())
    db_columns = list(column_map.values())
    rows = rows_from_csv(csv_path, csv_columns)
    placeholders = ", ".join("?" for _ in db_columns)
    cursor.executemany(
        f"INSERT INTO {table} ({', '.join(db_columns)}) VALUES ({placeholders})", rows
    )
    print(f"  {table:<24} {len(rows):>6,} rows")


def main() -> None:
    if DB_PATH.exists():
        DB_PATH.unlink()

    connection = sqlite3.connect(DB_PATH)
    cursor = connection.cursor()
    cursor.executescript(SCHEMA_PATH.read_text())
    print(f"Loading data into {DB_PATH.name}:")

    grammys_dir = ROOT / "01-grammys-website-analytics" / "data"
    traffic_columns = ["date", "visitors", "pageviews", "sessions", "bounced_sessions",
                       "avg_session_duration_secs", "awards_week", "awards_night"]

    # Both traffic feeds land in one table with a `site` label. Keeping them in a
    # single table is what makes the site-vs-site comparisons a GROUP BY instead of
    # a hand-written UNION in every query.
    for site, filename in [("grammys", "grammy_live_web_analytics.csv"),
                           ("recording_academy", "ra_live_web_analytics.csv")]:
        rows = rows_from_csv(grammys_dir / filename, traffic_columns)
        cursor.executemany(
            "INSERT INTO web_traffic (site, date, visitors, pageviews, sessions, "
            "bounced_sessions, avg_session_duration_secs, awards_week, awards_night) "
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
            [(site, *row) for row in rows],
        )
        print(f"  web_traffic ({site:<17}) {len(rows):>6,} rows")

    for site, filename in [("grammys", "grammys_age_demographics.csv"),
                           ("recording_academy", "tra_age_demographics.csv")]:
        rows = rows_from_csv(grammys_dir / filename, ["age_group", "pct_visitors"])
        cursor.executemany(
            "INSERT INTO age_demographics (site, age_group, pct_visitors) VALUES (?, ?, ?)",
            [(site, *row) for row in rows],
        )
        print(f"  age_demographics ({site:<11}) {len(rows):>6,} rows")

    for segment, filename in [("desktop", "desktop_users.csv"), ("mobile", "mobile_users.csv")]:
        rows = rows_from_csv(grammys_dir / filename, ["date", "visitors"])
        cursor.executemany(
            "INSERT INTO device_traffic (segment, date, visitors) VALUES (?, ?, ?)",
            [(segment, *row) for row in rows],
        )
        print(f"  device_traffic ({segment:<12}) {len(rows):>6,} rows")

    load(cursor, "olympic_medals",
         ROOT / "02-olympic-medalists" / "data" / "olympics.csv",
         {"ID": "id", "Name": "name", "Sex": "sex", "Age": "age", "Height": "height",
          "Weight": "weight", "NOC": "noc", "Games": "games", "Year": "year",
          "Season": "season", "City": "city", "Sport": "sport", "Event": "event",
          "Medal": "medal", "region": "country"})

    load(cursor, "park_visits",
         ROOT / "04-dc-national-parks" / "data" / "national_parks_recreation_visits.csv",
         {"ParkName": "park_name", "RecreationVisits": "recreation_visits"})

    load(cursor, "park_monthly",
         ROOT / "04-dc-national-parks" / "data" / "monthly_dc_visitors.csv",
         {"Month": "month", "RecreationVisits": "recreation_visits",
          "NonRecreationVisits": "non_recreation_visits",
          "RecreationHours": "recreation_hours",
          "NonRecreationHours": "non_recreation_hours"})

    connection.commit()

    print("\nRow counts:")
    for (table,) in cursor.execute(
        "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"
    ).fetchall():
        count = cursor.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
        print(f"  {table:<20} {count:>7,}")

    connection.close()
    print(f"\nDone. Query it with:  sqlite3 {DB_PATH.name} < queries.sql")


if __name__ == "__main__":
    main()
