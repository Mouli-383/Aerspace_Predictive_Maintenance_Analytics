from datetime import datetime

import pandas as pd


def process_cmapss_data(
    df: pd.DataFrame,
    dataset_id: str,
    data_type: str,
) -> pd.DataFrame:
    """
    Process validated CMAPSS train or test data.

    Parameters
    ----------
    df : pd.DataFrame
        Validated CMAPSS DataFrame.

    dataset_id : str
        CMAPSS dataset identifier.
        Example: FD001

    data_type : str
        Type of data.
        Example: TRAIN or TEST

    Returns
    -------
    pd.DataFrame
        Processed CMAPSS dataset.
    """

    print(f"\n[INFO] Processing {dataset_id} {data_type} data...")

    # --------------------------------------------------
    # 1. CREATE A COPY
    # --------------------------------------------------

    processed_df = df.copy()

    # --------------------------------------------------
    # 2. ENSURE ENGINE AND CYCLE ARE INTEGERS
    # --------------------------------------------------

    processed_df["engine_id"] = (
        processed_df["engine_id"].astype(int)
    )

    processed_df["cycle"] = (
        processed_df["cycle"].astype(int)
    )

    # --------------------------------------------------
    # 3. ENSURE OTHER COLUMNS ARE NUMERIC
    # --------------------------------------------------

    numeric_columns = processed_df.columns.drop(
        ["engine_id", "cycle"]
    )

    processed_df[numeric_columns] = (
        processed_df[numeric_columns]
        .apply(pd.to_numeric, errors="coerce")
    )

    # --------------------------------------------------
    # 4. ADD DATASET METADATA
    # --------------------------------------------------

    processed_df["dataset_id"] = dataset_id

    processed_df["data_type"] = data_type

    # --------------------------------------------------
    # 5. ADD PROCESSING TIMESTAMP
    # --------------------------------------------------

    processed_df["processed_at"] = datetime.now()

    # --------------------------------------------------
    # 6. SORT DATA
    # --------------------------------------------------

    processed_df = processed_df.sort_values(
        by=["engine_id", "cycle"]
    ).reset_index(drop=True)

    print(
        f"[SUCCESS] Processing completed for "
        f"{dataset_id} {data_type}"
    )

    print(
        f"[INFO] Final shape: {processed_df.shape}"
    )

    return processed_df


def process_rul_data(
    df: pd.DataFrame,
    dataset_id: str,
) -> pd.DataFrame:
    """
    Process validated CMAPSS RUL data.

    Parameters
    ----------
    df : pd.DataFrame
        Validated RUL DataFrame.

    dataset_id : str
        CMAPSS dataset identifier.
        Example: FD001

    Returns
    -------
    pd.DataFrame
        Processed RUL DataFrame.
    """

    print(f"\n[INFO] Processing {dataset_id} RUL data...")

    # --------------------------------------------------
    # 1. CREATE A COPY
    # --------------------------------------------------

    processed_df = df.copy()

    # --------------------------------------------------
    # 2. ENSURE CORRECT DATA TYPES
    # --------------------------------------------------

    processed_df["engine_id"] = (
        processed_df["engine_id"].astype(int)
    )

    processed_df["remaining_useful_life"] = (
        processed_df["remaining_useful_life"].astype(int)
    )

    # --------------------------------------------------
    # 3. ADD DATASET METADATA
    # --------------------------------------------------

    processed_df["dataset_id"] = dataset_id

    # --------------------------------------------------
    # 4. ADD PROCESSING TIMESTAMP
    # --------------------------------------------------

    processed_df["processed_at"] = datetime.now()

    # --------------------------------------------------
    # 5. SORT BY ENGINE ID
    # --------------------------------------------------

    processed_df = processed_df.sort_values(
        by="engine_id"
    ).reset_index(drop=True)

    print(
        f"[SUCCESS] Processing completed for "
        f"{dataset_id} RUL data"
    )

    print(
        f"[INFO] Final shape: {processed_df.shape}"
    )

    return processed_df