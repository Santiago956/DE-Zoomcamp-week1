# Data Engineering Zoomcamp — Week 1

Practical setup for Week 1 of the Data Engineering Zoomcamp. You get a local Postgres stack for experimentation, lightweight ingestion scripts, and Terraform configs to provision GCP storage and BigQuery.

---

## What's here

- Docker Compose: Postgres 17 + pgAdmin for quick local SQL work.
- Python scripts: small demo pipeline that writes Parquet and a chunked CSV→Postgres loader.
- Terraform: creates a GCS bucket and a BigQuery dataset for the homework exercises.
- SQL: homework query snippets targeting the loaded taxi data.

---

## Repository layout

```text
.
├── .gitignore
├── main.tf                 # Terraform resources (GCS bucket, BigQuery dataset)
├── variables.tf            # Terraform variables
├── queries.sql             # Homework SQL queries
├── pipeline/
│   ├── docker-compose.yml  # Local Postgres + pgAdmin
│   ├── Dockerfile          # Optional image for running the pipeline
│   ├── ingest_data.py      # Streams NYC taxi CSVs into Postgres in chunks
│   ├── main.py             # Hello-world entrypoint
│   ├── pipeline.py         # Demo: writes output_<month>.parquet
│   └── pyproject.toml      # Python dependencies
└── keys/                   # Place your GCP service account JSON here (ignored)
```

---

## How to run locally (Postgres stack)

1) Create `pipeline/.env` (kept out of git):

   ```bash
   POSTGRES_USER=postgres
   POSTGRES_PASSWORD=postgres
   POSTGRES_DB=ny_taxi
   PGADMIN_DEFAULT_EMAIL=admin@local.test
   PGADMIN_DEFAULT_PASSWORD=admin
   ```

2) Bring up the services:

   ```bash
   cd pipeline
   docker compose up -d
   ```

   Postgres is on host port 5433; pgAdmin is at http://localhost:8080.

3) Tear down when done:

   ```bash
   docker compose down -v
   ```

---

## Python utilities

Install deps from `pipeline/pyproject.toml`.

- With uv:

  ```bash
  cd pipeline
  uv sync
  uv run python pipeline.py 1
  ```

- With pip:

  ```bash
  pip install pandas psycopg2-binary pyarrow sqlalchemy tqdm
  python pipeline/pipeline.py 1
  ```

`pipeline.py` writes `output_<month>.parquet` for a quick Parquet check. `ingest_data.py` streams NYC taxi CSV data into Postgres; adjust the connection settings at the bottom of the file (use port 5433 when talking to the Compose Postgres from the host).

---

## Terraform (GCP)

Creates:
- GCS bucket `bucket-terraform-<project_id>` with a lifecycle rule to abort incomplete multipart uploads after one day.
- BigQuery dataset named by `var.bq_dataset_name` (default `demo_dataset_terraform_wk1_dt`).

Typical flow:

```bash
export GOOGLE_PROJECT=<your_project_id>
terraform init
terraform plan -var="gcp_project_id=$GOOGLE_PROJECT" -var="credentials=./keys/my-cred.json"
terraform apply -var="gcp_project_id=$GOOGLE_PROJECT" -var="credentials=./keys/my-cred.json"
```

Tune `gcp_region`, `location`, or `bq_dataset_name` via `variables.tf`, `-var`, or tfvars files.

---

## SQL exercises

Homework queries live in `queries.sql` and assume tables like `tripdata_2025` and `taxi_zone`. Align table names with however you load the data.

---

## Notes

- Secrets and env files are ignored (`.env`, `*.json`, `*.tfvars`). Keep credentials in `keys/` only.
- If you plan to build the pipeline Docker image, generate `uv.lock` (and optionally `.python-version`) inside `pipeline/` first.
- Match the ingestion schema in `ingest_data.py` with your Postgres target table to avoid type mismatches.
