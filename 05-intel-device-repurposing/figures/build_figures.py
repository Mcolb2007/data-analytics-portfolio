"""Build charts from query totals recorded in the Intel SQL analysis."""

from pathlib import Path

import matplotlib.pyplot as plt

FIGURES = Path(__file__).resolve().parent
FIGURES.mkdir(exist_ok=True)

plt.rcParams.update({
    "figure.figsize": (10, 4.5),
    "figure.dpi": 120,
    "axes.grid": True,
    "grid.alpha": 0.25,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "font.size": 11,
})

ACCENT = "#1f77b4"
SECONDARY = "#d4a017"


def save(fig, name: str) -> None:
    path = FIGURES / name
    fig.tight_layout()
    fig.savefig(path, bbox_inches="tight")
    plt.close(fig)
    print(f"wrote {path.name}")


def savings_by_age() -> None:
    labels = ["Mid-age\n(4–6 years)", "Older\n(7+ years)"]
    kwh = [32.04, 48.02]
    co2 = [0.0140, 0.0210]

    fig, axes = plt.subplots(1, 2, figsize=(10, 4.2))

    axes[0].bar(labels, kwh, color=ACCENT, width=0.55)
    axes[0].set_ylabel("Average energy saved (kWh / device / year)")
    axes[0].set_title("Older devices save far more energy per unit")
    axes[0].set_ylim(0, 60)
    for x, value in zip(labels, kwh):
        axes[0].text(x, value + 1.2, f"{value:.2f}", ha="center")

    axes[1].bar(labels, co2, color=SECONDARY, width=0.55)
    axes[1].set_ylabel("Average CO₂ avoided (tons / device / year)")
    axes[1].set_title("The CO₂ gap matches the energy gap")
    axes[1].set_ylim(0, 0.028)
    for x, value in zip(labels, co2):
        axes[1].text(x, value + 0.0006, f"{value:.4f}", ha="center")

    fig.suptitle(
        "Intel device repurposing — per-device return by age bucket",
        y=1.02,
        fontsize=12,
    )
    fig.text(
        0.5,
        -0.04,
        "Source: queries/06_by_age_bucket.sql · recorded from SQL Pad. "
        "Newer devices are the largest share of volume and the lowest per-unit savings.",
        ha="center",
        fontsize=8,
        color="#555555",
    )
    save(fig, "01_savings_by_age.png")


def laptop_share() -> None:
    fig, ax = plt.subplots(figsize=(8, 4.2))
    sizes = [67, 33]
    ax.barh(
        ["Desktops", "Laptops"],
        [33, 67],
        color=["#9aa0a6", ACCENT],
        height=0.45,
    )
    ax.set_xlim(0, 100)
    ax.set_xlabel("Share of 2024 program volume (%)")
    ax.set_title("Laptops are already 67% of devices collected")
    ax.axvline(50, color="#cccccc", linewidth=1)
    for y, value in zip(["Desktops", "Laptops"], [33, 67]):
        ax.text(value + 1.2, y, f"{value}%", va="center")
    fig.text(
        0.5,
        -0.02,
        "Source: queries/05_by_device_type.sql · 601,740 devices total",
        ha="center",
        fontsize=8,
        color="#555555",
    )
    save(fig, "02_laptop_share.png")


def co2_by_region() -> None:
    labels = ["North America", "Asia"]
    tons = [0.0103, 0.0155]
    fig, ax = plt.subplots(figsize=(8, 4.2))
    ax.bar(labels, tons, color=[ACCENT, SECONDARY], width=0.5)
    ax.set_ylabel("Average CO₂ avoided (tons / device / year)")
    ax.set_title("The same device avoids more carbon on a dirtier grid")
    ax.set_ylim(0, 0.02)
    for x, value in zip(labels, tons):
        ax.text(x, value + 0.0004, f"{value:.4f}", ha="center")
    fig.text(
        0.5,
        -0.02,
        "Source: queries/07_by_region.sql · North America is 299,478 devices, "
        "most of program volume; Asia has the higher per-device CO₂ return.",
        ha="center",
        fontsize=8,
        color="#555555",
    )
    save(fig, "03_co2_by_region.png")


if __name__ == "__main__":
    savings_by_age()
    laptop_share()
    co2_by_region()
