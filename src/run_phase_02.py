from pathlib import Path

from ingestion.cmapss_ingestion import (
    load_cmapss_data,
    load_rul_data,
)

from validation.cmapss_validation import (
    validate_cmapss_data,
    validate_rul_data,
)

from processing.cmapss_processing import (
    process_cmapss_data,
    process_rul_data,
)


# ==================================================
# PROJECT PATHS
# ==================================================

PROJECT_ROOT = Path(__file__).resolve().parent.parent

RAW_DATA_DIR = PROJECT_ROOT / "data" / "raw" / "cmapss"

PROCESSED_DATA_DIR = (
    PROJECT_ROOT
    / "data"
    / "processed"
    / "FD001"
)


# ==================================================
# CREATE OUTPUT DIRECTORY
# ==================================================

PROCESSED_DATA_DIR.mkdir(
    parents=True,
    exist_ok=True,
)


# ==================================================
# DATASET CONFIGURATION
# ==================================================

DATASET_ID = "FD001"

TRAIN_FILE = RAW_DATA_DIR / "train_FD001.txt"

TEST_FILE = RAW_DATA_DIR / "test_FD001.txt"

RUL_FILE = RAW_DATA_DIR / "RUL_FD001.txt"


# ==================================================
# MAIN PIPELINE
# ==================================================

def run_pipeline():

    print("\n" + "=" * 60)
    print("PHASE 2 - CMAPSS DATA INGESTION PIPELINE")
    print("=" * 60)

    print(f"\nDataset: {DATASET_ID}")

    # ==============================================
    # STEP 1: INGEST DATA
    # ==============================================

    print("\n[STEP 1] INGESTING RAW DATA")

    train_df = load_cmapss_data(TRAIN_FILE)

    test_df = load_cmapss_data(TEST_FILE)

    rul_df = load_rul_data(RUL_FILE)


    # ==============================================
    # STEP 2: VALIDATE DATA
    # ==============================================

    print("\n[STEP 2] VALIDATING DATA")

    train_valid = validate_cmapss_data(
        train_df,
        "FD001 TRAIN",
    )

    test_valid = validate_cmapss_data(
        test_df,
        "FD001 TEST",
    )

    rul_valid = validate_rul_data(
        rul_df
    )


    # ==============================================
    # STOP PIPELINE IF VALIDATION FAILS
    # ==============================================

    if not all([
        train_valid,
        test_valid,
        rul_valid,
    ]):

        raise ValueError(
            "Pipeline stopped because data validation failed."
        )


    # ==============================================
    # STEP 3: PROCESS DATA
    # ==============================================

    print("\n[STEP 3] PROCESSING DATA")

    train_processed = process_cmapss_data(
        train_df,
        DATASET_ID,
        "TRAIN",
    )

    test_processed = process_cmapss_data(
        test_df,
        DATASET_ID,
        "TEST",
    )

    rul_processed = process_rul_data(
        rul_df,
        DATASET_ID,
    )


    # ==============================================
    # STEP 4: SAVE PROCESSED DATA
    # ==============================================

    print("\n[STEP 4] SAVING PROCESSED DATA")

    train_output = (
        PROCESSED_DATA_DIR
        / "train_FD001_processed.csv"
    )

    test_output = (
        PROCESSED_DATA_DIR
        / "test_FD001_processed.csv"
    )

    rul_output = (
        PROCESSED_DATA_DIR
        / "RUL_FD001_processed.csv"
    )


    train_processed.to_csv(
        train_output,
        index=False,
    )

    test_processed.to_csv(
        test_output,
        index=False,
    )

    rul_processed.to_csv(
        rul_output,
        index=False,
    )


    # ==============================================
    # PIPELINE COMPLETION
    # ==============================================

    print("\n" + "=" * 60)
    print("PHASE 2 PIPELINE COMPLETED SUCCESSFULLY")
    print("=" * 60)

    print("\nGenerated Files:")

    print(f"✓ {train_output}")

    print(f"✓ {test_output}")

    print(f"✓ {rul_output}")

    print("\nPipeline execution finished successfully.\n")


# ==================================================
# RUN PIPELINE
# ==================================================

if __name__ == "__main__":

    run_pipeline()