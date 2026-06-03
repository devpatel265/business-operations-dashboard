# Business Operations Dashboard Layout

This file describes how the Power BI dashboard should be built using the sample dataset.

## Dashboard Page: Executive Overview

### 1. Total Revenue KPI

**Visual type:** Card

**Metric:** Sum of `line_total` for completed orders.

**Why this visual was chosen:** A card makes the most important business result easy to see immediately.

**Business question answered:** How much revenue did the business generate?

### 2. Total Customers KPI

**Visual type:** Card

**Metric:** Distinct count of `customer_id`.

**Why this visual was chosen:** A card is best for a single headline number.

**Business question answered:** How large is the customer base?

### 3. Total Orders KPI

**Visual type:** Card

**Metric:** Distinct count of completed `order_id`.

**Why this visual was chosen:** Order count is a simple operational health metric that pairs well with revenue.

**Business question answered:** How many completed orders were placed?

### 4. Monthly Revenue Trend Chart

**Visual type:** Line chart

**Axis:** `order_date` grouped by month

**Values:** Sum of `line_total`

**Why this visual was chosen:** A line chart is ideal for showing change over time.

**Business question answered:** Is revenue growing, declining, or changing seasonally?

### 5. Top Products Bar Chart

**Visual type:** Horizontal bar chart

**Axis:** `product_name`

**Values:** Sum of `line_total`

**Why this visual was chosen:** A horizontal bar chart makes product names readable and clearly ranks products.

**Business question answered:** Which products generate the most revenue?

### 6. Revenue by Category Pie Chart

**Visual type:** Pie chart or donut chart

**Legend:** `category`

**Values:** Sum of `line_total`

**Why this visual was chosen:** This visual shows the revenue mix across a small number of categories.

**Business question answered:** Which product categories make up the largest share of sales?

### 7. Customer Distribution Visual

**Visual type:** Map, filled map, or horizontal bar chart

**Location field:** `state`

**Values:** Distinct count of `customer_id`

**Why this visual was chosen:** Location-based visuals help business users understand market concentration.

**Business question answered:** Where are customers located?

## Suggested Power BI Measures

```DAX
Total Revenue =
SUM(sample_dataset[line_total])
```

```DAX
Total Customers =
DISTINCTCOUNT(sample_dataset[customer_id])
```

```DAX
Total Orders =
DISTINCTCOUNT(sample_dataset[order_id])
```

```DAX
Average Order Value =
DIVIDE([Total Revenue], [Total Orders])
```

## Dashboard Screenshot Files

- `dashboard_screenshots/dashboard_overview.png`: Full executive dashboard mockup.
- `dashboard_screenshots/monthly_revenue_trend.png`: Focused revenue trend screenshot.
- `dashboard_screenshots/product_category_performance.png`: Product and category performance screenshot.

