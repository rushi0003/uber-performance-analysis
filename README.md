# Uber Mumbai Ride Analytics 🚕

### End-to-End Data Analytics Project \| Excel • PostgreSQL • Power BI

An end-to-end portfolio project analyzing **95,000+ synthetic ride
bookings in Mumbai** to understand booking demand, operational
performance, cancellations, weather effects, revenue, and customer
behavior.

> **Dataset note:** This is a **synthetic, educational dataset**. The
> findings are project insights, not official Uber performance figures.

## Project Overview

  -----------------------------------------------------------------------
  Item                                Details
  ----------------------------------- -----------------------------------
  Domain                              Ride-hailing / Transportation
                                      Analytics

  Geography                           Mumbai, India

  Data period                         15 October 2025 -- 14 October 2026

  Raw records                         96,055

  Clean records                       95,983

  Tools                               Microsoft Excel, PostgreSQL, Power
                                      BI

  Core techniques                     Data cleaning, SQL analysis, KPI
                                      reporting, DAX, dashboard design
  -----------------------------------------------------------------------

## Business Objectives

-   Track bookings, completed rides, gross booking value (GBV), average
    fare, and operational KPIs.
-   Identify high-demand areas, peak hours, and zone-to-zone ride
    patterns.
-   Examine weather-related changes in completion rate, wait times, and
    surge pricing.
-   Investigate driver cancellations, especially for short-distance
    trips.
-   Explore customer loyalty, ratings, payment behavior, and promotional
    effectiveness.
-   Present actionable findings in an interactive Power BI dashboard.

## Project Workflow

**Raw CSV → Excel Cleaning & Validation → PostgreSQL Analysis → Power BI
Modeling & Dashboard → Business Recommendations**

### 1. Excel --- Data Cleaning and Quality Checks

-   Reviewed raw data, column types, missing values, and duplicate ride
    IDs.
-   Removed **55 duplicate ride IDs** and **17 invalid completed-ride
    records**.
-   Standardized missing weather and payment-method values as `Unknown`.
-   Added analysis-friendly time attributes and performed quality
    checks.
-   Produced the cleaned dataset with **95,983 records**.

### 2. PostgreSQL --- Business Analysis

Used SQL queries and a clean-data view (`rides_clean`) for analyses
including:

-   Core ride and revenue KPIs
-   Monthly booking trends and growth
-   Top pickup areas and zone-level demand
-   Peak-hour and weather impact
-   Cancellation patterns and short-trip behavior
-   Promo effectiveness and vehicle performance
-   Customer frequency and spending segmentation
-   Driver contribution and anomaly detection

### 3. Power BI --- Interactive Dashboard

Built a four-page dashboard using a ride fact table, area dimension,
date dimension, DAX measures, and page-specific filters.

  -----------------------------------------------------------------------
  Page                    Main visuals            Focus
  ----------------------- ----------------------- -----------------------
  **01 --- Executive      KPI cards, monthly      Business health and
  Overview**              rides chart, vehicle    revenue
                          mix donut               

  **02 --- Area &         Area treemap, top       Geographic demand
  Demand**                pickup areas,           
                          zone-to-zone matrix     

  **03 --- Time &         Hour × weekday heatmap, Temporal and weather
  Weather**               hourly surge, weather   patterns
                          completion and wait     
                          charts                  

  **04 --- Cancellations  Cancellation reasons,   Service quality and
  & Customers**           distance-based          customer behavior
                          cancellation, ratings   
                          vs wait, customer       
                          segments, promo         
                          comparison              
  -----------------------------------------------------------------------

## Key Project Findings

The following figures are **project-guide benchmarks**. Confirm the
final values against your published Excel, SQL, and Power BI outputs
before presenting them as independently validated results.

  -----------------------------------------------------------------------
  Metric / finding                    Project benchmark
  ----------------------------------- -----------------------------------
  Clean bookings                      **95,983**

  Completed rides                     **77,530**

  Completion rate                     **\~80.8%**

  Gross booking value (GBV)           **\~₹2.15 crore**

  Average completed-ride fare         **\~₹277.68**

  Heavy-rain completion rate          **68.5%**, versus **82.7%** in
                                      clear weather

  Heavy-rain average wait             **10.3 min**, versus **5.7 min** in
                                      clear weather

  Short-trip driver cancellation      **\~14%** for rides under 2.5 km,
                                      versus **\~7.5%** for normal trips

  Loyal customers                     Customers with **9+ rides** account
                                      for \~**41%** of spending in the
                                      project analysis

  Promotional discounts               **\~₹3.04 lakh** total discount
                                      cost
  -----------------------------------------------------------------------

## Business Recommendations

1.  **Strengthen peak-hour driver supply:** Use hourly demand and surge
    patterns to plan driver availability.
2.  **Prepare for heavy rain:** Improve supply coverage and customer
    wait-time communication during adverse weather.
3.  **Investigate short-trip cancellations:** Test targeted incentives
    and monitor cancellation rates by trip-distance bucket.
4.  **Prioritize high-demand pickup areas:** Use area and zone analyses
    to guide driver positioning.
5.  **Support customer retention:** Explore loyalty campaigns for repeat
    riders while measuring incremental impact.
6.  **Evaluate promotions carefully:** Compare promo spend and
    performance, without assuming observed differences prove causation.

## Dashboard Screenshots

> Add exported dashboard images to `04_Power_BI/Dashboard_Screenshots/`
> using the filenames below. GitHub will display them automatically when
> present.

### Executive Overview

![Executive Overview
Dashboard](04_Power_BI/Dashboard_Screenshots/01_Executive_Overview.png)

### Area & Demand Analysis

![Area and Demand
Dashboard](04_Power_BI/Dashboard_Screenshots/02_Area_Demand.png)

### Time & Weather Analysis

![Time and Weather
Dashboard](04_Power_BI/Dashboard_Screenshots/03_Time_Weather.png)

### Cancellations & Customers

![Cancellations and Customers
Dashboard](04_Power_BI/Dashboard_Screenshots/04_Cancellations_Customers.png)

## Repository Structure

``` text
Uber-Mumbai-Ride-Analytics/
├── README.md
├── 01_Data/
│   ├── Raw_Data/
│   └── Cleaned_Data/
├── 02_Excel/
├── 03_SQL/
├── 04_Power_BI/
│   ├── Uber_Mumbai_Dashboard.pbix
│   └── Dashboard_Screenshots/
│       ├── 01_Executive_Overview.png
│       ├── 02_Area_Demand.png
│       ├── 03_Time_Weather.png
│       └── 04_Cancellations_Customers.png
├── 05_Reports/
└── 06_Documentation/
```

*The structure above is a suggested organization. Keep filenames
consistent with the files you actually upload.*

## How to Explore the Project

1.  Start with this README and the dashboard screenshots.
2.  Open the Excel workbook in `02_Excel/` to review cleaning and
    quality checks.
3.  Review the PostgreSQL scripts in `03_SQL/` to understand the
    business questions and analysis.
4.  Open the `.pbix` file in `04_Power_BI/` using Power BI Desktop.
5.  If the Power BI file references local CSV paths, update the data
    source settings to point to your downloaded files and refresh.

## Skills Demonstrated

`Excel` · `Data Cleaning` · `Data Validation` · `PostgreSQL` ·
`SQL Joins` · `CTEs` · `Window Functions` · `KPI Analysis` ·
`Power Query` · `DAX` · `Data Modeling` · `Power BI` ·
`Data Visualization` · `Business Insights`

------------------------------------------------------------------------

**Disclaimer:** This repository is an independent learning and portfolio
project using synthetic data. It is not affiliated with or endorsed by
Uber.
