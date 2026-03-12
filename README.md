**# cyclistic-bike-share-analysis**

A data analytics case study analyzing 3.6 million rows of bike-share data using Python, SQL, and Tableau.


**Project Overview**

Cyclistic, a bike-share program featuring a fleet of over 5,800 bicycles and 600 docking stations, relies on two primary consumer segments: casual riders (purchasing single-ride or full-day passes) and annual members. Financial modeling dictates that annual members are significantly more profitable than casual riders.

The primary business objective of this project was to analyze 12 months of historical trip data to uncover actionable behavioral differences between these two cohorts. The resulting insights were used to design targeted, data-driven marketing strategies aimed at converting casual riders into highly profitable annual members.


**The Tech Stack & Architecture**

To process and analyze 3.6 million rows of data efficiently, I engineered a robust ETL (Extract, Transform, Load) pipeline and visualization workflow using enterprise-grade tools:

Python: Automated the extraction of 12 months of raw CSV files (March 2025 – February 2026) from an AWS S3 bucket and loaded them into a local database.

MySQL: Executed advanced data engineering to clean, format, and structure the 3.6 million records. Utilized SQL aggregation to run hypothesis testing and generate summary statistics.

Tableau: Connected directly to the MySQL database to design an interactive, executive-facing dashboard that visually communicates the behavioral divide between user segments.


**Key Insights & Strategic Recommendations**

The analysis revealed a stark behavioral divide:

The Daily Commuter: Annual members exhibit a bimodal traffic pattern, heavily utilizing the bikes during morning (8:00 AM) and evening (5:00 PM) rush hours during the workweek for short, efficient, ~12-minute point-to-point rides.

The Weekend Warrior: Casual riders display a unimodal traffic pattern, peaking in the mid-afternoon on Saturdays and Sundays. Their rides stretch to an average of 25+ minutes, indicating a strong preference for leisure and sightseeing.


**Actionable Next Steps:**

Rather than targeting casual riders with weekday commuter campaigns, marketing efforts should be reallocated to "Weekend Warrior" initiatives. Recommendations include creating a weekend-specific annual pass, deploying location-based digital ads near tourist hubs on Friday afternoons, and gamifying the app to reward long weekend rides with heavily discounted introductory annual memberships.

<img width="1883" height="932" alt="visualization_of_findings" src="https://github.com/user-attachments/assets/508bddb3-306e-42fa-972e-ca1e87710c89" />
