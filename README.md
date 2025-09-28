# SQL Analytics Project (GoIT Data Analytics Course)

This repository contains my first SQL analytics project completed as part of the **GoIT Data Analytics program**.  
The project demonstrates the use of **DBeaver** and **BigQuery** to query and analyze marketing and e-commerce datasets.

## Project Overview

- **Tools used:** DBeaver, PostgreSQL, Google BigQuery, Google Analytics 4 dataset  
- **Focus areas:**  
  - Writing and optimizing SQL queries  
  - Preparing data for BI systems  
  - Calculating KPIs and conversions  
  - Exporting query results into reusable formats (CSV)

The repository is divided into two parts:

1. **DBeaver Ads Analysis (Tasks 1.1–1.5)**  
   Based on Facebook and Google Ads datasets. Focused on campaign performance, ROMI, reach, and adsets.  

2. **BigQuery GA4 E-commerce Analysis (Tasks 2–5)**  
   Based on the GA4 sample e-commerce dataset. Focused on sessions, events, conversions, page paths, and user engagement.

---

## Repository Structure
<pre> ```text GoIT-my-first-project/ ├─ dbeaver_ads/ # SQL queries and results for Ads dataset │ ├─ *.sql │ └─ outputs/*.csv ├─ bigquery/ # SQL queries and results for GA4 dataset │ ├─ *.sql │ └─ outputs/*.csv ├─ README.md ├─ LICENSE └─ .gitignore ``` </pre>



⚠️ Note: CSV files may contain only partial outputs (sample rows).  
Full results can be reproduced by running the SQL queries on the source datasets.

## DBeaver Tasks (1.1–1.5)

**Dataset:** Facebook Ads + Google Ads (basic daily tables)

- **1.1 — Ads Overview**  
  Min/Max/Avg for spend, impressions, clicks, leads, and value by date and media source.  
  [SQL](dbeaver_ads/task1_1_ads_overview.sql) | [CSV](dbeaver_ads/outputs/task1_1_ads_overview.csv)

- **1.2 — ROMI by Date**  
  Daily ROMI = (SUM(value) - SUM(spend)) / SUM(spend) * 100.  
  [SQL](dbeaver_ads/task1_2_romi_by_date.sql) | [CSV](dbeaver_ads/outputs/task1_2_romi_by_date.csv)

- **1.3 — Best Campaign of the Week**  
  Highest `SUM(value)` per week and campaign.  
  [SQL](dbeaver_ads/task1_3_best_campaign_week.sql) | [CSV](dbeaver_ads/outputs/task1_3_best_campaign_week.csv)

- **1.4 — Reach Month-over-Month Change**  
  Absolute MoM difference in reach per campaign.  
  [SQL](dbeaver_ads/task1_4_reach_mom_diff.sql) | [CSV](dbeaver_ads/outputs/task1_4_reach_mom_diff.csv)

- **1.5 — Longest Running Adset**  
  Longest continuous streak of active days with impressions per adset.  
  [SQL](dbeaver_ads/task1_5_longest_running_adset.sql) | [CSV](dbeaver_ads/outputs/task1_5_longest_running_adset.csv)


## BigQuery Tasks (2–5)

**Dataset:** Google Analytics 4 — Obfuscated Sample E-commerce Events

- **2 — Events, Users, Sessions**  
  Extract event timestamp, user ID, session ID, event name, country, device, traffic source, and campaign for 2021.  
  [SQL](bigquery/task2_events_users_sessions.sql) | [CSV](bigquery/outputs/task2_results.csv)

- **3 — Conversions by Channel and Date**  
  Conversion funnel metrics (visit → cart → checkout → purchase) per traffic source, medium, and campaign.  
  [SQL](bigquery/task3_conversions_by_channel.sql) | [CSV](bigquery/outputs/task3_results.csv)

- **4 — Page Path Conversion Rate**  
  Conversion rate from session start to purchase by page path.  
  [SQL](bigquery/task4_page_path_conversion.sql) | [CSV](bigquery/outputs/task4_results.csv)

- **5 — Engagement Correlation**  
  Correlation between engagement time and purchase likelihood.  
  [SQL](bigquery/task5_engagement_correlation.sql) | [CSV](bigquery/outputs/task5_results.csv)


### BigQuery Saved Queries
- Task 2 — [Open in BigQuery]([https://console.cloud.google.com/bigquery?savedQuery=task_2](https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1sstoried-pixel-469204-d9!2sus-central1!3sf40e7127-f51d-49f6-b931-6e0e14c6607f!2e1)
- Task 3 — [Open in BigQuery]([https://console.cloud.google.com/bigquery?savedQuery=task_3](https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1sstoried-pixel-469204-d9!2sus-central1!3sce17fffe-b19b-4eec-92c6-11d6c3d619aa!2e1)
- Task 4 — [Open in BigQuery]([https://console.cloud.google.com/bigquery?savedQuery=task_4](https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1sstoried-pixel-469204-d9!2sus-central1!3s5ed2029e-c512-47cc-98aa-aa74656c62aa!2e1)
- Task 5 — [Open in BigQuery]([https://console.cloud.google.com/bigquery?savedQuery=task_5](https://console.cloud.google.com/bigquery?ws=!1m7!1m6!12m5!1m3!1sstoried-pixel-469204-d9!2sus-central1!3sf3f72518-f171-41a1-928a-21a982a210c2!2e1)


---

## How to Reproduce

1. Clone this repository:
   ```bash
   git clone https://github.com/khrysyna-data-analyst/GoIT-my-first-project.git
2. Open .sql files in DBeaver or BigQuery console.

3. Run queries on the provided datasets:
   - DBeaver: facebook_ads_basic_daily, google_ads_basic_daily
   - BigQuery: bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*

4. Compare with partial CSV outputs.

