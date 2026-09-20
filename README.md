
## **Online Retail — ELT Pipeline, RFM & K-Means Segmentation**
An end-to-end data pipeline and customer segmentation project using the [UCI Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail). 

The project extracts raw transaction data, loads it into a PostgreSQL database, performs SQL-based RFM aggregation, applies rule-based segmentation, and builds a K-Means clustering model (k=6) to uncover deeper behavioral segments. 

### Architecture & Workflow

**1. Extract & Load**
- Python (`ucimlrepo` / `pandas`) extracts the raw dataset.
- Raw transactions are loaded into PostgreSQL.

**2. Transform (SQL)**
- Data cleaning (handling nulls, cancellations, invalid values, duplicates).
- RFM aggregation executed in SQL: `GROUP BY customer_id` to calculate Recency, Frequency, and Monetary values.

**3. Rule-Based Segmentation (Python)**
- Quartile scoring (`pd.qcut`) applied to R, F, and M.
- Rule-based mapping assigns customers to intuitive segments (e.g., Champions, At Risk, Lost).

**4. K-Means Clustering (Python)**
- Features scaled using `StandardScaler` within a `make_pipeline`.
- Hyperparameter tuning: Elbow Method and Silhouette Scores evaluated for `k=2` to `12`.
- Final model trained with `k=6`, validated by a peak in the Silhouette Score and the flattening of the inertia curve.
- **New Insight:** K-Means isolated extreme high-value outliers into a dedicated "VIP" cluster (median spend ~$225k) and resolved the "mixed middle" rule-based buckets into distinct actionable groups.

**5. Interactive Dashboard**  
[View the Interactive Power BI Dashboard](https://app.powerbi.com/view?r=eyJrIjoiOWJkYjNmMzktZmFmZi00OGEzLTljNjAtOTRjMjUyY2ZiNTNjIiwidCI6Ijk2MDk5YjY1LTIwMWItNGQ4YS04ZDA1LTQwMjFkZDU3OWI5YiJ9)


**Tools**: Python, PostgreSQL, pandas, matplotlib, seaborn, scikit-learn (StandardScaler, KMeans), Power BI.