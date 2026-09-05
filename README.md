# Online Retail — ELT Pipeline & RFM Customer Segmentation

A data pipeline project using the [UCI Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail).

## Approach
- **Extract:** Python (`ucimlrepo` / pandas)
- **Load:** Raw data loaded into PostgreSQL (Supabase)
- **Transform:** Cleaning (nulls, cancellations, invalid values, duplicates) and RFM
  aggregation done in SQL — `GROUP BY customer_id` for Recency, Frequency, and Monetary
- **Score & segment:** Quartile scoring (`pd.qcut`) and rule-based segmentation done in
  Python, then visualized with matplotlib/seaborn

**Tools**: Python, PostgreSQL (Supabase), pandas, matplotlib, seaborn.


## Status
🚧 In progress — a K-Means clustering comparison against the rule-based RFM segments
is planned as a next step.
