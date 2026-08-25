-- Relational model for the portfolio datasets.
--
-- Design decisions:
--   * The two website feeds share one `web_traffic` table with a `site` column
--     rather than living in separate tables. Site comparisons then become a
--     GROUP BY instead of a UNION repeated in every query.
--   * Columns that can legitimately be unknown (age, height, weight, temperature)
--     stay nullable. Columns an analysis depends on are NOT NULL so a bad load
--     fails at insert time instead of producing quietly wrong aggregates.
--   * CHECK constraints encode what I verified in the Python notebooks, so the
--     database refuses data that contradicts those findings.

DROP TABLE IF EXISTS web_traffic;
DROP TABLE IF EXISTS age_demographics;
DROP TABLE IF EXISTS device_traffic;
DROP TABLE IF EXISTS olympic_medals;
DROP TABLE IF EXISTS park_visits;
DROP TABLE IF EXISTS park_monthly;

-- Daily website analytics for both Recording Academy properties.
CREATE TABLE web_traffic (
    id                        INTEGER PRIMARY KEY,
    site                      TEXT    NOT NULL CHECK (site IN ('grammys', 'recording_academy')),
    date                      TEXT    NOT NULL,
    visitors                  INTEGER NOT NULL,
    pageviews                 INTEGER NOT NULL,
    sessions                  INTEGER NOT NULL CHECK (sessions > 0),
    bounced_sessions          INTEGER NOT NULL,
    avg_session_duration_secs REAL    NOT NULL,
    awards_week               INTEGER NOT NULL CHECK (awards_week IN (0, 1)),
    awards_night              INTEGER NOT NULL CHECK (awards_night IN (0, 1)),
    UNIQUE (site, date)
);

CREATE INDEX idx_traffic_site_date ON web_traffic (site, date);

-- Audience age mix per site (percentages, one row per bracket).
CREATE TABLE age_demographics (
    site         TEXT NOT NULL,
    age_group    TEXT NOT NULL,
    pct_visitors REAL NOT NULL,
    PRIMARY KEY (site, age_group)
);

-- Grammys traffic split by device, used for the mobile-share analysis.
CREATE TABLE device_traffic (
    segment  TEXT    NOT NULL CHECK (segment IN ('desktop', 'mobile')),
    date     TEXT    NOT NULL,
    visitors INTEGER NOT NULL,
    PRIMARY KEY (segment, date)
);

-- One row per medal awarded, 1896-2016.
CREATE TABLE olympic_medals (
    id      INTEGER,        -- athlete id: repeats across events, so not a primary key
    name    TEXT    NOT NULL,
    sex     TEXT    NOT NULL CHECK (sex IN ('M', 'F')),
    age     REAL,           -- nullable: not recorded in the earliest Games
    height  REAL,           -- nullable: ~75% missing before 1936
    weight  REAL,           -- nullable: same reason as height
    noc     TEXT    NOT NULL,
    games   TEXT    NOT NULL,
    year    INTEGER NOT NULL,
    season  TEXT    NOT NULL CHECK (season IN ('Summer', 'Winter')),
    city    TEXT    NOT NULL,
    sport   TEXT    NOT NULL,
    event   TEXT    NOT NULL,
    medal   TEXT    NOT NULL CHECK (medal IN ('Gold', 'Silver', 'Bronze')),
    country TEXT            -- nullable: 9 rows arrive without one (all Singapore)
);

CREATE INDEX idx_medals_year  ON olympic_medals (year);
CREATE INDEX idx_medals_sport ON olympic_medals (sport);

-- 2024 recreation visits per National Park Service site in the DC area.
CREATE TABLE park_visits (
    park_name         TEXT    PRIMARY KEY,
    recreation_visits INTEGER NOT NULL
);

-- DC-wide monthly totals for 2024.
CREATE TABLE park_monthly (
    month                  INTEGER PRIMARY KEY CHECK (month BETWEEN 1 AND 12),
    recreation_visits      INTEGER NOT NULL,
    non_recreation_visits  INTEGER NOT NULL,
    recreation_hours       INTEGER NOT NULL,
    non_recreation_hours   INTEGER NOT NULL
);
