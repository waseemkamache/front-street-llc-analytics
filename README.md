# Front Street Pizza | Sales & Customer Review Analytics

A business analytics project examining restaurant sales performance and customer feedback.

## Interactive Dashboard

### [View the Sales & Customer Review Dashboard](https://datastudio.google.com/reporting/34f33eb1-62d7-4012-afd4-09bf88a50250)

The interactive dashboard contains two pages:

- **Sales Performance:** Revenue, units sold, product rankings, and sales volume.
- **Customer Reviews:** Star-rating distribution, customer feedback categories, review classifications, and average ratings by topic.

## Project Overview

This project analyzes six months of display-counter product sales and customer reviews from Front Street Pizza.

The objective was to identify revenue-driving products, evaluate customer feedback, and develop actionable business recommendations using SQL and data visualization.

The project demonstrates database management, data preparation, SQL analysis, dashboard development, data visualiation, and business communication.

## Tools and Technologies

- **MySQL:** Data analysis, joins, aggregations, CTEs, CASE statements, and views.
- **Looker Studio:** Interactive dashboard development and data visualization.
- **Excel and CSV:** Data preparation, organization, and export.

## Key Performance Indicators

### Sales Performance

| Metric | Result |
|---|---:|
| Display-Counter Revenue | $66,663.98 |
| Units Sold | 18,622 |
| Products Analyzed | 18 |

### Customer Reviews

| Metric | Result |
|---|---:|
| Reviews Analyzed | 84 |
| Average Customer Rating | 4.08 / 5 |
| Positive Reviews | 64 |
| Positive Review Percentage | 76.19% |
| Negative Reviews | 19 |

## Key Business Findings

### 1. Plain Slices Are a Major Revenue Driver

Plain Slices generated $18,999.17 in revenue from 6,304 units sold, making them the highest-selling individual display-counter product.

Maintaining consistent availability and testing complementary product placement may help support sales performance.

### 2. Customer Service Is the Most Frequently Assigned Review Topic

Customer Service was assigned to 31 reviews, including 27 positive reviews.

Identifying service behaviors mentioned favorably and encouraging customers to leave honest reviews could help the restaurant maintain consistent service standards and gather additional feedback.

### 3. Delivery and Wait-Time Feedback Warrants Closer Examination

Two reviews were assigned to Delivery & Wait Time, and both received one-star ratings.

Although the sample is too small to establish how widespread these issues are, reviewing the comments may help identify opportunities to improve preparation times, pickup coordination, or delivery expectations.

### 4. Consistent Review Collection Could Improve Customer Feedback

Review activity appears to occur in waves, with some feedback associated with specific events rather than routine dining experiences.

Consistently encouraging customers to leave honest reviews through checkout reminders or a QR code could help the restaurant gather feedback more regularly.

This observation is qualitative; exact review-posting dates were not available to verify the timing or magnitude of review activity.

## Data Sources and Methodology

### Sales Data

Product-level quantities and revenue were obtained from actual Square sales aggregates covering six months of display-counter sales.

**At the business owner's discretion, individual transaction records were synthetically generated for the SQL analysis rather than using actual customer transaction records.**

The synthetic records were reconciled to the actual product-level quantities and revenue totals.

This approach allowed SQL practice involving relational tables, joins, aggregations, and transaction-level analysis while respecting the owner's data-sharing preferences.

Actual product-level results are used for factual business findings. Analyses involving synthetic order dates, transaction frequency, basket composition, or purchasing patterns are illustrative and do not represent observed customer behavior.

### Customer Review Data

The review analysis uses 84 customer reviews.

A keyword-based SQL view assigns one primary topic to each review, including:

- Customer Service
- Food Quality
- Delivery & Wait Time
- External Incident
- No Written Review
- Other / Unclear

Reviews explicitly identified as discussing an external incident were classified separately to distinguish their subject matter from routine food and service feedback.

Overall star ratings were used to classify reviews as positive, neutral, or negative.

## Project Limitations

- Synthetic transaction records do not represent actual individual orders, transaction timing, basket composition, or customer purchasing patterns.
- Actual sales findings are based on product-level aggregates, not observed customer-level transaction behavior.
- Keyword-based review classification assigns one primary topic per review, even when multiple subjects are mentioned.
- A keyword match does not independently establish whether a particular subject was praised or criticized.
- Reviews without written feedback do not provide an explanation for their ratings.
- Relative review ages do not allow precise measurement of review activity over time.
- Findings describe the analyzed dataset and should not be assumed to represent every customer experience.

## Repository Files

| File | Description |
|---|---|
| `FSP-sales-analytics.sql` | SQL queries analyzing restaurant sales performance |
| `FSP-review-analytics.sql` | SQL queries analyzing customer ratings and review topics |
| `FSP-Business-Findings.docx` | Business findings and practical recommendations |

## Dashboard

The interactive Looker Studio dashboard visualizes the project's sales and review analysis.

**[Open the Front Street Pizza Analytics Dashboard](https://datastudio.google.com/reporting/34f33eb1-62d7-4012-afd4-09bf88a50250)**
