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

The focus was not just building tables, but covering the full dbt workflow:

* cleaning messy numeric values (e.g. `"1,5"` → `1.5`)
* writing reusable macros
* adding built-in tests (`not_null`, `unique`, `relationships`)
* creating custom tests (e.g. orphan record checks)
* adding unit tests with mock data
* using snapshots for historical tracking
* implementing an incremental model on the fact table

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
