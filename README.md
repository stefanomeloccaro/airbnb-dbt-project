# Airbnb dbt Project

## What this is

This is a personal project where I used dbt and Snowflake to build a small analytics pipeline starting from raw Airbnb-style CSV data.

The goal was to take messy input data and turn it into something clean, structured, and usable for analysis.

---

## How I structured it

I followed a standard layered approach:

* **Raw (L0)** → data loaded as-is from CSV
* **Staging (L1)** → cleaning and standardization (types, nulls, formats)
* **Marts (L2)** → final analytical layer (star schema)

Staging is intentionally kept simple and focused only on data preparation.
All analytical logic lives in the marts layer.

---

## Data model

**Staging**

* `stg_listings`
* `stg_hosts`
* `stg_reviews`
* `stg_neighbourhoods`

**Dimensions**

* `dim_hosts`
* `dim_listings`
* `dim_neighbourhoods`

**Fact**

* `fct_reviews` (one row per review)

---

## What I worked on

The focus was not just building tables, but covering the main parts of a dbt project end to end:

* **Data cleaning** – handling messy numeric values, type casting, nulls, and inconsistent formats in staging
* **YAML configuration** – organizing schema files correctly across staging and marts for tests, descriptions, and model settings
* **Sources and refs** – using `source()` for raw data and `ref()` to build dependencies and lineage across models
* **Macros** – writing reusable logic to avoid repeating the same SQL patterns
* **Advanced macros** – adding more flexible logic for repeated transformations and conditional handling
* **Built-in tests** – using `not_null`, `unique`, `relationships`, and `accepted_values`
* **Singular tests** – writing standalone SQL checks that must return zero rows
* **Custom generic tests** – creating reusable tests, including tests with parameters
* **Severity settings** – using warnings selectively when the dataset quality should not block the pipeline
* **Store failures** – saving failing test rows for debugging and audit purposes
* **Unit tests** – validating transformations with mock input and expected output
* **Snapshots** – tracking historical changes without relying on an unreliable `updated_at` column
* **Data contracts** – enforcing schema definitions on selected marts models
* **Incremental models** – applying incremental logic to improve performance on the fact table
* **Materializations** – using the appropriate materialization depending on the model purpose (`view`, `table`, `incremental`, and `snapshot`)
* **Third-party packages** – using `dbt_utils`, including helpers like surrogate key generation


---

## Notes on design choices

This project was built with the goal of demonstrating familiarity with dbt features, rather than applying every feature everywhere.

Some functionalities (like custom tests, macros, or specific configurations) are intentionally implemented only once or in a limited scope. The idea was to show how and when to use them, without over-engineering the project.

In a real production setup, some of these patterns would likely be applied more consistently.

---

## Challenges

The dataset is not perfect, which made the project more realistic.

Some issues I ran into:

* missing or inconsistent keys
* partially broken CSVs
* columns with a high number of nulls

Instead of forcing perfect data, I:

* filtered invalid records where needed
* allowed some tests to warn instead of fail
* treated the dataset as something closer to a real-world scenario

---

## How to run

```bash
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

## Why I built this

The main goal was to get comfortable with:

* structuring a dbt project properly
* separating staging and marts responsibilities
* understanding when to use snapshots vs incremental models
* working with imperfect data instead of ideal examples

---

## Next steps

* add business-level marts (KPIs, aggregations)
* build a simple dashboard on top of the data
