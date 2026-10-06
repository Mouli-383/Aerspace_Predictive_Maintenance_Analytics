from pathlib import Path

import pandas as pd


# --------------------------------------------------
# CMAPSS COLUMN DEFINITIONS
# --------------------------------------------------

COLUMN_NAMES = (
    ["engine_id", "cycle"]
    + [
        "operational_setting_1",
        "operational_setting_2",
        "operational_setting_3",
    ]
    + [f"sensor_{i}" for i in range(1, 22)]
)


def load_cmapss_data(file_path: Path) -> pd.DataFrame:
    """
    Load a NASA CMAPSS train or test dataset.

    Parameters
    ----------
    file_path : Path
        Path to the CMAPSS text file.

    Returns
    -------
    pd.DataFrame
        CMAPSS dataset with meaningful column names.
    """

    print(f"[INFO] Loading file: {file_path.name}")

    df = pd.read_csv(
        file_path,
        sep=r"\s+",
        header=None,
    )

    # Keep only the actual 26 CMAPSS columns
    df = df.iloc[:, :26]

    # Assign meaningful column names
    df.columns = COLUMN_NAMES

    print(f"[SUCCESS] Loaded {len(df):,} records")
    print(f"[INFO] Shape: {df.shape}")

    return df


def load_rul_data(file_path: Path) -> pd.DataFrame:
    """
    Load the NASA CMAPSS Remaining Useful Life file.

    Parameters
    ----------
    file_path : Path
        Path to the RUL text file.

    Returns
    -------
    pd.DataFrame
        RUL values with a generated engine ID.
    """

    print(f"[INFO] Loading RUL file: {file_path.name}")

    df = pd.read_csv(
        file_path,
        sep=r"\s+",
        header=None,
    )

    # Keep only the actual RUL column
    df = df.iloc[:, :1]

    df.columns = ["remaining_useful_life"]

    # Generate engine IDs based on row order
    df.insert(
        0,
        "engine_id",
        range(1, len(df) + 1),
    )

    print(f"[SUCCESS] Loaded RUL for {len(df):,} engines")
    print(f"[INFO] Shape: {df.shape}")

    return df