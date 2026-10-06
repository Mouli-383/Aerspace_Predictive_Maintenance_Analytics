# Aerospace Predictive Maintenance Analytics Platform

## 1. Project Overview

The Aerospace Predictive Maintenance Analytics Platform is a data engineering and analytics project built using the NASA C-MAPSS FD001 dataset.

The project processes aircraft engine sensor and operating-cycle data and transforms it into analytical datasets for engine health, degradation, risk assessment, fleet health, and maintenance priority analysis.

The project focuses on data ingestion, processing, validation, data warehousing, transformation, and analytics.

---

## 2. Dataset Information

### Dataset

NASA C-MAPSS (Commercial Modular Aero-Propulsion System Simulation) - FD001

### Dataset Files

- train_FD001.txt - Training engine-cycle data
- test_FD001.txt - Testing engine-cycle data
- RUL_FD001.txt - Remaining Useful Life data

### Dataset Attributes

Each engine-cycle record contains:

- Engine ID
- Cycle
- 3 Operational Settings
- 21 Sensor Measurements

The project also maintains Remaining Useful Life (RUL) information for the engines.

---

## 3. Technologies Used

- Python
- SQL
- SQL Server
- Snowflake
- dbt
- Git

---

## 4. Project Architecture

NASA C-MAPSS FD001
        |
        v
Dataset Profiling
        |
        v
Python Ingestion
        |
        v
Python Processing
        |
        v
Data Validation
        |
        v
SQL Server
        |
        v
Snowflake RAW
        |
        v
dbt STAGING
        |
        v
dbt Transformations
        |
        v
Analytics Marts
        |
        v
Engine Health & Maintenance Analytics

---

## 5. Project Structure

Aerospace_Predictive_Maintenance_Analytics/
|
|-- aerospace_predictive_maintenance_dbt/
|   |-- analyses/
|   |-- dbt_packages/
|   |-- logs/
|   |-- macros/
|   |-- models/
|   |-- seeds/
|   |-- snapshots/
|   |-- target/
|   `-- dbt_project.yml
|
|-- data/
|   |-- curated/
|   |-- metadata/
|   |-- processed/
|   |   `-- FD001/
|   |       |-- train_FD001_processed.csv
|   |       |-- test_FD001_processed.csv
|   |       `-- RUL_FD001_processed.csv
|   |
|   `-- raw/
|       `-- cmapss/
|           |-- Damage Propagation Modeling.pdf
|           |-- readme.txt
|           |-- train_FD001.txt
|           |-- test_FD001.txt
|           `-- RUL_FD001.txt
|
|-- notebooks/
|   `-- phase_01/
|       `-- phase_01_dataset_profiling.ipynb
|
|-- sql/
|   |-- snowflake/
|   `-- sql_server/
|       |-- ddl/
|       |-- dml/
|       |-- procedures/
|       `-- validation_queries/
|
|-- src/
|   |-- analytics/
|   |-- database/
|   |-- ingestion/
|   |   `-- cmapss_ingestion.py
|   |-- processing/
|   |   `-- cmapss_processing.py
|   |-- utils/
|   `-- validation/
|       `-- cmapss_validation.py
|
|-- tests/
|   |-- integration/
|   `-- unit/
|
|-- requirements.txt
`-- README.md

---

## 6. Dataset Profiling

The project starts with dataset profiling using:

notebooks/phase_01/phase_01_dataset_profiling.ipynb

The profiling stage is used to understand the structure and characteristics of the CMAPSS FD001 dataset before processing and loading.

---

## 7. Data Ingestion

Python is used for data ingestion.

The ingestion logic is implemented in:

src/ingestion/cmapss_ingestion.py

The project separately handles:

- Training data
- Testing data
- RUL data

---

## 8. Data Processing

The processing logic is implemented in:

src/processing/cmapss_processing.py

Processed datasets are stored under:

data/processed/FD001/

The processed files include:

- train_FD001_processed.csv
- test_FD001_processed.csv
- RUL_FD001_processed.csv

---

## 9. Data Validation

Data validation is implemented using:

src/validation/cmapss_validation.py

Additional SQL validation queries are maintained under:

sql/sql_server/validation_queries/

The validation layer checks the processed and loaded data before downstream analytics.

---

## 10. SQL Server Layer

The SQL Server implementation is organized into:

- DDL
- DML
- Stored Procedures
- Validation Queries

Database and table creation are handled through SQL scripts.

The project also contains an engine summary stored procedure.

The validation queries are used to verify tables, validate loaded data, and perform basic data analysis.

---

## 11. Snowflake Data Warehouse

The project creates a Snowflake warehouse:

AEROSPACE_WH

The warehouse uses an X-Small configuration with auto-suspend and auto-resume enabled.

The project database is:

AEROSPACE_PREDICTIVE_MAINTENANCE_DB

The database contains three schemas:

- RAW
- STAGING
- ANALYTICS

### RAW Layer

The RAW layer contains:

- TRAIN_DATA
- TEST_DATA
- RUL_DATA

The project also creates:

- CMAPSS_CSV_FORMAT
- CMAPSS_STAGE

for handling and loading the processed CSV data.

---

## 12. dbt Transformation

The project uses dbt to transform raw engine data into structured analytical datasets.

The dbt project contains models, macros, seeds, snapshots, analyses, and tests.

The transformation process includes:

- Engine sensor trend analysis
- Lifecycle percentage calculation
- Sensor deviation calculation
- Degradation metric calculation
- Engine health score calculation
- Risk-level classification

---

## 13. Engine Sensor Trend Analysis

The project contains the intermediate model:

INT_ENGINE_SENSOR_TRENDS

The model provides information such as:

- Data source
- Engine ID
- Cycle
- Maximum cycle
- Lifecycle percentage

This helps analyze the position of an engine within its operating lifecycle.

---

## 14. Engine Degradation Analysis

The project contains the intermediate model:

INT_ENGINE_DEGRADATION_METRICS

The model includes metrics such as:

- Lifecycle percentage
- Sensor 2 deviation
- Sensor 7 deviation
- Average sensor deviation

These metrics are used to analyze changes in engine sensor behavior.

---

## 15. Engine Health Scoring

The project contains the intermediate model:

INT_ENGINE_HEALTH_SCORES

The model derives:

- Degradation score
- Engine health score
- Risk level

The project also queries high-risk engines using the risk-level classification.

---

## 16. Analytics Marts

The project creates the following analytical marts:

### MART_ENGINE_CURRENT_HEALTH

Provides the current health and risk status of engines.

### MART_ENGINE_HEALTH_HISTORY

Provides engine health information across operating cycles.

### MART_FLEET_HEALTH

Provides a fleet-level view of engine health.

### MART_MAINTENANCE_PRIORITY

Provides maintenance-oriented information based on engine risk and maintenance priority.

---

## 17. Maintenance Priority Analysis

The maintenance priority mart is analyzed using:

- Data source
- Engine ID
- Risk level
- Maintenance priority

The project calculates the number of engines belonging to different risk and maintenance-priority categories.

This provides a structured view that can help identify engines requiring greater maintenance attention.

---

## 19. Data Quality Testing

The project includes SQL-based data-quality tests covering:

- Duplicate engine-cycle records
- Duplicate current-engine records
- Duplicate maintenance records
- Missing RUL values
- Negative RUL values
- Negative degradation scores
- Invalid maximum cycles
- Lifecycle percentage range
- Engine health score range
- Cycle consistency

These tests help ensure the reliability of the transformed and analytical datasets.

---

## 20. Testing Structure

The project contains:

tests/
|-- integration/
`-- unit/

Additional SQL-based validation tests are maintained for specific business and data-quality rules.

---

## 21. Final Data Flow

Raw CMAPSS Data
      |
      v
Dataset Profiling
      |
      v
Python Ingestion
      |
      v
Python Processing
      |
      v
Data Validation
      |
      v
SQL Server
      |
      v
Snowflake RAW
      |
      v
dbt STAGING
      |
      v
Sensor Trend Analysis
      |
      v
Degradation Metrics
      |
      v
Engine Health Scores
      |
      v
Analytics Marts
      |
      v
Maintenance Priority

---

## 22. Project Outcome

The project transforms raw aircraft engine sensor data into structured analytical datasets.

The final analytical layer provides information about:

- Engine lifecycle
- Sensor behavior
- Sensor deviations
- Degradation
- Engine health
- Risk level
- Fleet health
- Maintenance priority

The project demonstrates an end-to-end data engineering workflow using Python, SQL Server, Snowflake, dbt.

The project focuses on building a reliable data and analytics pipeline for predictive-maintenance use cases rather than implementing a machine-learning model.
