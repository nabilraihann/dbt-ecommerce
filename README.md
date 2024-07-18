# DBT E-commerce

![dbt-logo](https://www.getdbt.com/ui/img/logos/dbt-logo.svg)

## Description

This repository contains a DBT (Data Build Tool) project for e-commerce data analysis. This project is designed to facilitate the management and transformation of data from various e-commerce sources into clean data models that can be used for further analysis.

## Project Structure

```plaintext
dbt-ecommerce/
├── README.md
├── analysis/
├── data/
├── dbt_project.yml
├── logs/
├── models/
│   ├── stg/
│   |-- mart/
├── snapshots/
├── tests/
└── target/
```

## Prerequisites

Before running this project, ensure you have followed the instructions in this repository: [ClickHouse E-commerce](https://github.com/nabilraihann/clickhouse-ecommerce)

Additionally, make sure you have installed:

- [Miniconda](https://docs.conda.io/en/latest/miniconda.html)

## Installation

1. Clone this repository to your local machine:

    ```bash
    git clone https://github.com/nabilraihann/dbt-ecommerce.git
    cd dbt-ecommerce
    ```

2. Create a virtual environment using conda and activate it:

    ```bash
    conda create --name dbt-ecommerce python=3.9
    conda activate dbt-ecommerce
    ```

3. Install the required dependencies:

    ```bash
    pip install -r requirements.txt
    ```

4. Configure the `profiles.yml` file on your `.dbt` directory to set up the database connection. Example configuration:

    ```yaml
    dbt_ecommerce:
      target: dev
      outputs:
        dev:
          type: clickhouse
          schema: dwh
          user: default
          password: ""
    ```

## Usage

### Running DBT

To run the DBT project and build the models:

```bash
dbt run

```

### DBT dag result

![dag](https://github.com/nabilraihann/dbt-ecommerce/blob/main/dbt-dag.png)
