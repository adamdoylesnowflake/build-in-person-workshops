# Build 2025 — Snowflake Data Engineering Workshop

Welcome to the Data Engineering Workshop for Snowflake Build 2025! This repository contains setup scripts and reference materials to help you get started with data engineering concepts using Snowflake.


## What’s here

- `setup.sql` — setups up you Snowflake account for the workshop.

## Prerequisites

- Access to a Snowflake account
- `ACCOUNTADMIN` role or equivalent privileges


## What Gets Created

### Warehouse
- **COMPUTE_WH**: X-Small warehouse with auto-suspend (5 minutes) and auto-resume enabled

### Databases
- **RAW_DB**: Storage for raw, unprocessed data
- **ANALYTICS_DB**: Storage for transformed and analytics-ready data

### Sample Tables

- **CUSTOMERS**: 1,000 synthetic customer records
- **PRODUCTS**: 100 synthetic product records
- **ORDERS**: 10,000 synthetic order records (last 10 days)


## License

See `LICENSE` for details.