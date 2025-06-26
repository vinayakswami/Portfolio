# Healthcare Data Analysis & Insights
<h1>📌 Problem Statement</h1>
Built a dynamic dashboard to analyze healthcare data to extract actionable insights that could help improve patient care and healthcare resource management. By working with multiple datasets, I utilized various Excel techniques to clean, transform, and analyze the data to uncover meaningful patterns.

<h1>Project Overview</h1>
I have focused on analyzing healthcare data, such as patient health profiles, medical histories, and healthcare costs. The insights gained from this analysis are intended to assist healthcare stakeholders in making informed decisions regarding patient care and resource allocation.

<h1>📊 Data Understanding</h1>
The dataset includes the following key attributes:
- Patient Health Profile: BMI, Blood Sugar Levels, Smoking Status
- Medical History: Heart Issues, Transplants, Cancer History, Number of Major Surgeries
- Healthcare Costs: Hospital Charges, Hospital Tier, City Tier
- Demographics: Age, State ID
  
⚙️ <h1>Technology Stack</h1>
ETL Process in Excel: Data preprocessing using formulas and functions
Pivot Tables: Data aggregation and summarization
Data Visualization: Charts, slicers, and dashboards

<h1>🏗️ Methodology</h1>
<h3>1. Data Cleaning & Preparation</h3>
- Removed duplicates and unnecessary columns.
- Standardized data format using text functions - TRIM , SEARCH , LENGTH , PROPER
- Bucketing(using NESTIF) - Categorized BMI into Underweight, Healthy, Overweight, and Obese.
- Bucketing(using NESTIF) - Classified blood sugar levels as Normal, Pre-Diabetic, and Diabetic.
- Performed EDA to unlock key metrics of the dataset using logical and conditional formulas i.e, AVERAGEIF, COUNTIF, SUMIF, for aggregation
- Utilized Vlookup for joining multiple sheets and transfered the cleaned data into a new sheet using paste-values.
- Created Pivot Tables to generate key insights.

<h3>2. Dashboard Creation</h3>
- Designed an interactive Excel dashboard.
- Used dynamic charts and slicers for filtering insights.
- Visualized trends in BMI, Blood Sugar, and Hospital Charges.
  
<h3>3.📈 Data Analysis & Key Insights Generated</h3>
- Smoking and Cancer Risk: Non-smokers had a higher cancer history, suggesting that other factors contribute to cancer risk.
- Obesity & Cancer Correlation: Overweight and obese patients showed a higher incidence of cancer.
- Obesity & Hospital Costs: Obese patients incurred higher hospital charges, even with normal blood sugar levels.
- Region-Wise Costs: Tier 2 hospitals had the highest charges, potentially due to limited healthcare infrastructure.
- Age & Cost Relaionship: Hospital charges increased with age, with a sharp rise after 60.
  
<h1>🔹Conclusion</h1>
This analysis highlights the importance of maintaining a healthy weight and blood sugar levels to prevent cancer and reduce healthcare costs. 
Additionally, Tier 2 cities should focus on improving healthcare infrastructure and awareness to minimize hospital charges.
