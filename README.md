# App Review Analysis for Product Improvement

## 📌 Project Overview

This Business Analyst portfolio project analyzes 161 Google Play Store reviews to understand user satisfaction, identify recurring feedback themes, and highlight areas for further investigation.

The project uses Python for data cleaning, sentiment classification, and theme analysis, followed by Excel-based KPI analysis and dashboard reporting.

## 🎯 Business Objective

The objective is to convert unstructured app reviews into actionable business insights by:

- Measuring overall user satisfaction
- Analyzing rating distribution
- Classifying review sentiment
- Identifying recurring feedback themes
- Finding areas that may require product improvement
- Providing data-driven recommendations

## 🛠️ Tools & Technologies

- Python
- Pandas
- VADER Sentiment Analysis
- Excel
- Data Cleaning
- Sentiment Analysis
- Keyword-based Theme Classification
- Data Visualization
- Business Analysis

## 🔄 Analysis Workflow

Raw Reviews  
↓  
Data Cleaning with Python  
↓  
Sentiment Classification  
↓  
Theme Classification  
↓  
KPI & Statistical Analysis  
↓  
Excel Dashboard  
↓  
Business Insights & Recommendations

## 📊 Key Results

| KPI | Result |
|---|---:|
| Total Reviews | 161 |
| Average Rating | 4.42 / 5 |
| Positive Reviews | 85.09% |
| Negative Reviews | 7.45% |
| Neutral Reviews | 7.45% |
| 5-Star Reviews | 112 |
| Login & Password Reviews | 38 |
| Backup & Migration Reviews | 20 |

## 🔍 Key Insights

- 85.09% of the analyzed reviews were classified as positive.
- 112 out of 161 reviews received 5 stars.
- The **Login & Password** theme had 38 reviews, with 21.05% classified as negative.
- **Backup & Migration** had 20 reviews and the lowest average rating among the main identified themes at 3.65.
- **Bugs & Performance** had a smaller volume of reviews, with 20% classified as negative.
- **Usability** had an average rating of 4.86 across 21 reviews.

## 💡 Business Recommendations

- Investigate recurring login and password-related complaints.
- Analyze backup, restore, and device-transfer feedback.
- Monitor bugs, crashes, errors, and update-related complaints.
- Maintain usability features associated with positive user feedback.
- Continue collecting a larger review sample for stronger analysis.

## 🧪 Methodology

### Sentiment Analysis

VADER Sentiment Analysis was used to classify reviews into:

- Positive
- Negative
- Neutral

### Theme Classification

Keyword-based rules were used to categorize reviews into themes such as:

- Login & Password
- Backup & Migration
- Usability
- Bugs & Performance
- Security
- Features & Customization
- Advertising
- Pricing & Free Plan
- Other

## ⚠️ Limitations

- Sentiment classification was automated using VADER.
- Theme classification was based on keyword rules.
- The dataset contains 161 reviews.
- Automated classifications were not manually validated for every review.
- The analysis identifies associations and patterns; it does not establish causation.
- Some generic reviews may fall under the "Other" category.

## 📁 Project Files

| File | Description |
|---|---|
| `app_review_analysis.py` | Python data cleaning, sentiment and theme analysis |
| `App_Review_Analyzed.xlsx` | Cleaned data, KPI analysis, theme analysis and dashboard |
| `GooglePlay_App_Data.csv` | Raw Google Play review dataset |
| `App_Review_Analysis_BA_Report.docx` | Detailed Business Analyst project report |

## 👩‍💻 Author

**Diksha Kshirsagar**

Business Analyst / Data Analytics Portfolio Project
