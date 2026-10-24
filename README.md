# Uber Mumbai Ride Analytics 🚕

### End-to-End Data Analytics Portfolio Project | Excel • PostgreSQL • Power BI

An end-to-end analysis of **95,983 cleaned synthetic ride bookings** across Mumbai, exploring booking demand, revenue, operational performance, cancellations, weather conditions, and customer behavior. The project follows a practical analytics workflow: **data validation and cleaning → SQL business analysis → interactive Power BI reporting → recommendations**.

> **Dataset disclaimer:** The dataset is synthetic and used for educational purposes. The results do **not** represent Uber's actual business performance. This project is independent and is not affiliated with or endorsed by Uber.

## Project at a Glance

| Attribute | Details |
|---|---|
| Domain | Ride-hailing / Transportation Analytics |
| Geography | Mumbai, India |
| Dataset period | 15 October 2025 – 14 October 2026 |
| Raw bookings | 96,055 |
| Clean bookings | 95,983 |
| Tools | Microsoft Excel, PostgreSQL, Power BI |
| Techniques | Data cleaning, validation, SQL, KPIs, DAX, data modeling, visualization |

## Business Questions

1. How many bookings are completed, and what is the overall gross booking value (GBV)?
2. Which areas, zones, hours, and days generate the most demand?
3. How do heavy rain and surge pricing relate to completion rates and waiting times?
4. Which trip segments experience higher driver cancellation rates?
5. How do vehicle types, promotions, payment methods, and repeat customers contribute to performance?
6. Where could operations teams improve driver supply and customer experience?

## Analytics Workflow

### 1. Excel — Cleaning and Quality Assurance

- Inspected the raw data for duplicate ride IDs, missing values, and invalid ride records.
- Removed **55 duplicate ride IDs** and **17 invalid completed-ride records**.
- Standardized missing weather and payment-method entries as `Unknown`.
- Prepared time-based attributes and performed data quality checks.
- Reduced the dataset from **96,055** to **95,983** bookings for analysis.

### 2. PostgreSQL — Business Analysis

Used SQL and a clean-data view named `rides_clean` to investigate:

- Core booking, completion, fare, and revenue metrics
- Monthly demand trends and growth
- High-demand pickup areas and zone-to-zone flows
- Peak-hour behavior and weather effects
- Driver cancellations and short-distance trips
- Promotions and vehicle categories
- Customer ride frequency and spending
- Driver contribution and unusual booking patterns

### 3. Power BI — Dashboard and Reporting

Created an interactive four-page report using a ride fact table, date and area dimensions, DAX measures, and page-specific filters.

| Dashboard page | Main analysis |
|---|---|
| **01 — Executive Overview** | Booking and revenue KPIs, monthly trends, vehicle mix |
| **02 — Area & Demand** | Pickup-area demand, geographic distribution, zone-to-zone movements |
| **03 — Time & Weather** | Hourly and weekday demand, surge pricing, weather-related completion and wait times |
| **04 — Cancellations & Customers** | Cancellation reasons, trip distance, ratings, customer segments, promotion comparisons |

### Dashboard PDF

**[View the complete Power BI Dashboard (PDF)](./Power%20BI/Uber%20Ride%20Analytics%20Dashboard.pdf)**

The repository includes an exported PDF of the Power BI report for viewing without Power BI Desktop. The four dashboard sections are described above; use the PDF to inspect the published visuals.

## Key Findings

The figures below are **project analysis benchmarks** documented in the project materials; individual values should be reconciled with the final Excel, SQL, and Power BI calculations before external reporting.

| Metric | Finding |
|---|---:|
| Total cleaned bookings | **95,983** |
| Completed rides | **77,530** |
| Completion rate | **~80.8%** |
| Gross booking value (GBV) | **~₹2.15 crore** |
| Average completed-ride fare | **~₹277.68** |
| Heavy-rain completion rate | **68.5%** vs **82.7%** in clear weather |
| Average wait in heavy rain | **10.3 min** vs **5.7 min** in clear weather |
| Driver cancellation on trips under 2.5 km | **~14%** vs **~7.5%** on other trips |
| Spending by customers with 9+ rides | **~41%** of analyzed spending |
| Total promotional discounts | **~₹3.04 lakh** |

### Interpretation

**Weather and reliability:** Heavy rain is associated with lower completion rates and longer waiting times, indicating an opportunity to plan driver coverage and communicate realistic ETAs.

**Short-trip cancellations:** Trips below 2.5 km show a higher driver cancellation rate, making them a useful segment for targeted operational experiments.

**Customer retention:** Frequent riders account for a substantial share of spending, suggesting that repeat-customer behavior deserves attention in retention analysis.

**Promotion economics:** Discount costs should be compared with incremental bookings and customer retention; descriptive comparisons alone cannot establish that promotions caused an improvement.

## Business Recommendations

1. **Improve peak-hour driver coverage:** Align driver availability with high-demand hours and pickup areas.
2. **Plan for adverse weather:** Monitor rain-related supply shortages, wait times, and booking completion.
3. **Test short-trip incentives:** Evaluate carefully targeted driver incentives and track cancellation rates before and after implementation.
4. **Optimize geographic allocation:** Use area and zone-level booking patterns to support driver positioning.
5. **Monitor loyal customers:** Measure repeat-rider retention and spending without assuming correlation implies causation.
6. **Review promotion efficiency:** Assess discount costs against measurable business outcomes.

## Repository Contents

The following are the **top-level items visible in the published repository**:

```text
uber-performance-analysis/
├── raw data/                              # Original data
├── Clean data/                            # Cleaned project data
├── SQL/                                   # SQL analysis files
├── Power BI/                              # Power BI project files
│   └── Uber Ride Analytics Dashboard.pdf  # Exported dashboard
├── Rushikesh Gund Uber Analytics PPT.pptx # Project presentation
└── README.md                              # Project documentation
```

> Folder and file names are case-sensitive in GitHub URLs. The structure above reflects the visible repository root; individual filenames inside folders are not assumed.

## Explore the Project

- [Raw data](./raw%20data/)
- [Cleaned data](./Clean%20data/)
- [SQL analysis](./SQL/)
- [Power BI dashboard PDF](./Power%20BI/Uber%20Ride%20Analytics%20Dashboard.pdf)
- [Power BI files](./Power%20BI/)
- [Project presentation](./Rushikesh%20Gund%20Uber%20Analytics%20PPT.pptx)

To review the analysis, begin with the cleaned data, explore the SQL scripts, then open the available Power BI report files in **Power BI Desktop**. If a report references local source paths, update its data source settings and refresh the model.

## Skills Demonstrated

**Microsoft Excel:** Data cleaning, validation, quality checks, and analytical preparation  
**PostgreSQL:** KPI queries, grouping, joins, CTEs, window functions, and business analysis  
**Power BI:** Data modeling, DAX measures, interactive dashboards, and storytelling  
**Business Analytics:** Demand analysis, operational performance, cancellations, customer behavior, and recommendations

---

**Project type:** Independent educational portfolio project using synthetic Mumbai ride-hailing data.  
**Repository:** [Uber Performance Analysis](https://github.com/rushi0003/uber-performance-analysis)
