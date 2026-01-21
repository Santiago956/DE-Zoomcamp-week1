# Data Engineering Zoomcamp — Week 1 Homework

This repository contains the solution for the **Week 1 Homework** of the **Data Engineering Zoomcamp** by **DataTalks.Club**.

The goal of this project is to **set up a local and cloud-based data engineering environment**, using **Docker** to orchestrate services (PostgreSQL) and **Terraform** to provision infrastructure on **Google Cloud Platform (GCP)**.

---

## Project Architecture

- **Docker & Docker Compose**
  - PostgreSQL running in a container
  - SQL scripts for data creation and querying
  - Python script for reading Parquet files

- **Terraform (GCP)**
  - Infrastructure provisioning on GCP
  - Use of variables for better reusability

---

## Repository Structure

```text
.
├── data/                  # Data used in the project
├── docker-compose.yml     # Container orchestration
├── parquet_reader.py      # Python script to read Parquet files
├── queries.sql            # SQL queries used in the homework
├── README.md              # Project documentation
├── .gitignore             # Git ignored files
│
├── main.tf                # Terraform resources
├── variables.tf           # Terraform variables
├── .terraform.lock.hcl    # Terraform lock file

