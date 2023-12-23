# dbt-blueprint
This repository serves as a foundational template for initiating and managing dbt projects. It provides a structured framework, best practices, sample models, tests, and documentation to jumpstart your analytics engineering workflows.

## 1. Clone the repository

To start, clone the repository to your local machine. Use the following command in your terminal.

```bash
git clone [repository URL]
cd [repository name]
```

## 2. Create virtual environment

Set up a virtual environment to manage dependencies for this project.

```
python -m venv venv
source venv/bin/activate
```

## 3. Configure profiles.yml

The `profiles.yml` file contains configuration settings for your dbt profile, including details to connect to your DuckDB databases.

1. Create a `profiles.yml` file in your `~/.dbt/` directory.
2. Edit the file to include the connection details for your data warehouse.

```
dbt_blueprint:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: databases/raw.duckdb
      alias: raw
      schema: dev
      threads: 1
      attach:
        - path: 'databases/staging.duckdb'
          alias: staging
        - path: 'databases/analytics.duckdb'
          alias: analytics
```

## 4. Execute dbt_setup.sh

Execute the `dbt_setup.sh` script to install dbt and other dependencies and test the connection.

```
./dbt_setup.sh
```


## 5. Run dbt build

Compile and run the dbt models along with tests.

```
dbt build
```