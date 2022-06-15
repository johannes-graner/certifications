# Fundamentals of Data Visualization
Mainly for DAs
- charts in Excel
- vis. in notebooks
  - Synapse
  - Databricks
- BI tools

## Power BI
- Several tools and services
  - desktop app
  - phone app
  - web browser
  - Power BI Service
- Workflow
  - Create reports in Power BI Desktop
  - Publish to Power BI Service
    - Can do simple modeling and report editing in Web interface to Service
    - Schedule report refreshing based on new data
    - Create dashboards
  - Consume dashboards and reports in web browser or phone app

## Core concepts of Data Modeling
- OLAP Cube model
  - numeric values to analyze (e.g. revenue) are called **measures**
  - entities aggregated over are called **dimensions**
- Model is stored as star schemas
  - measures are central fact tables
  - dimension tables are related to by keys
    - Time is almost always included as a dimension
  - If dimensions have further relations to tables (e.g. product to category), it's a snowflake schema
- In the model, ALL measure aggregations over ALL dimensions are pre-calculated
  - Allows extremely fast switching of aggregation levels

### Attribute hierarchies
- hierarchy = aggregation level
  - e.g. customer/city/country
  - e.g. day/month/year
- Hierarchy change is called drill-up or drill-down
  - drill-up: coarser level (month -> year)
  - drill-down: finer level (month -> day)

### AMs in Power BI
- Import tables with data for analytical model (AM)
- data modeling interface
  - relations between facts and dimensions
  - hierarchies
  - data types
  - display formats

## Considerations for visualization
- Use model to create visualizations
- Tables and text
  - simple
  - good for several related values
  - exact metrics
  - less intuitive
- Bar and column charts
  - compare numeric values for discrete categories
- Line charts
  - compare categorized values
  - shows trends
- Pie charts
  - proportions of total
- Scatter plots
  - identify correlations
- Maps
  - geo data

### Interactive reports in Power BI
- Link several visualizations
  - link aggregation level
  - link filters (e.g. sales in Seattle)