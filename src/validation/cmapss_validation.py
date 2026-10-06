import pandas as pd


def validate_cmapss_data(df: pd.DataFrame, dataset_name: str) -> bool:
    """
    Validate a CMAPSS train or test dataset.

    Parameters
    ----------
    df : pd.DataFrame
        CMAPSS dataset to validate.

    dataset_name : str
        Name used for validation messages.

    Returns
    -------
    bool
        True if validation passes.
    """

    print(f"\n{'=' * 50}")
    print(f"VALIDATING: {dataset_name}")
    print(f"{'=' * 50}")

    validation_passed = True

    # --------------------------------------------------
    # 1. CHECK EXPECTED COLUMN COUNT
    # --------------------------------------------------

    expected_columns = 26

    if df.shape[1] != expected_columns:
        print(
            f"[ERROR] Expected {expected_columns} columns, "
            f"but found {df.shape[1]}"
        )
        validation_passed = False
    else:
        print(
            f"[PASS] Column count is correct: "
            f"{expected_columns}"
        )

    # --------------------------------------------------
    # 2. CHECK FOR MISSING VALUES
    # --------------------------------------------------

    missing_values = df.isnull().sum().sum()

    if missing_values > 0:
        print(
            f"[ERROR] Missing values found: "
            f"{missing_values}"
        )
        validation_passed = False
    else:
        print("[PASS] No missing values found")

    # --------------------------------------------------
    # 3. CHECK FOR DUPLICATE ROWS
    # --------------------------------------------------

    duplicate_rows = df.duplicated().sum()

    if duplicate_rows > 0:
        print(
            f"[WARNING] Duplicate rows found: "
            f"{duplicate_rows}"
        )
    else:
        print("[PASS] No duplicate rows found")

    # --------------------------------------------------
    # 4. CHECK ENGINE-CYCLE UNIQUENESS
    # --------------------------------------------------

    duplicate_engine_cycles = (
        df.duplicated(
            subset=["engine_id", "cycle"]
        ).sum()
    )

    if duplicate_engine_cycles > 0:
        print(
            f"[ERROR] Duplicate engine-cycle records found: "
            f"{duplicate_engine_cycles}"
        )
        validation_passed = False
    else:
        print(
            "[PASS] Every engine-cycle combination "
            "is unique"
        )

    # --------------------------------------------------
    # 5. CHECK ENGINE IDS
    # --------------------------------------------------

    unique_engines = df["engine_id"].nunique()

    if unique_engines == 0:
        print("[ERROR] No engines found")
        validation_passed = False
    else:
        print(
            f"[PASS] Engines found: {unique_engines}"
        )

    # --------------------------------------------------
    # FINAL RESULT
    # --------------------------------------------------

    print(f"{'=' * 50}")

    if validation_passed:
        print(
            f"[SUCCESS] {dataset_name} validation PASSED"
        )
    else:
        print(
            f"[FAILED] {dataset_name} validation FAILED"
        )

    print(f"{'=' * 50}\n")

    return validation_passed


def validate_rul_data(df: pd.DataFrame) -> bool:
    """
    Validate the CMAPSS RUL dataset.

    Parameters
    ----------
    df : pd.DataFrame
        RUL DataFrame.

    Returns
    -------
    bool
        True if validation passes.
    """

    print(f"\n{'=' * 50}")
    print("VALIDATING: RUL DATA")
    print(f"{'=' * 50}")

    validation_passed = True

    # Check expected columns
    expected_columns = [
        "engine_id",
        "remaining_useful_life",
    ]

    if list(df.columns) == expected_columns:
        print("[PASS] RUL columns are correct")
    else:
        print(
            f"[ERROR] Unexpected RUL columns: "
            f"{list(df.columns)}"
        )
        validation_passed = False

    # Check missing values
    missing_values = df.isnull().sum().sum()

    if missing_values > 0:
        print(
            f"[ERROR] Missing RUL values found: "
            f"{missing_values}"
        )
        validation_passed = False
    else:
        print("[PASS] No missing RUL values")

    # Check duplicate engine IDs
    duplicate_engines = df["engine_id"].duplicated().sum()

    if duplicate_engines > 0:
        print(
            f"[ERROR] Duplicate engine IDs found: "
            f"{duplicate_engines}"
        )
        validation_passed = False
    else:
        print("[PASS] Engine IDs are unique")

    # Check negative RUL
    negative_rul = (
        df["remaining_useful_life"] < 0
    ).sum()

    if negative_rul > 0:
        print(
            f"[ERROR] Negative RUL values found: "
            f"{negative_rul}"
        )
        validation_passed = False
    else:
        print("[PASS] No negative RUL values")

    print(f"{'=' * 50}")

    if validation_passed:
        print("[SUCCESS] RUL validation PASSED")
    else:
        print("[FAILED] RUL validation FAILED")

    print(f"{'=' * 50}\n")

    return validation_passed