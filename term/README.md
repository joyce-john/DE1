## Term Project

### Overview

This project analyzes the 2016 Seattle AirBnB market using data provided by AirBnB's official Kaggle account. You can view the data at its original source here:

https://www.kaggle.com/airbnb/seattle

The aim of this project is to deliver useful information about the market to the user, who might be an analyst at AirBnB, a property owner in Seattle, or a prospective real estate investor. The database has several data marts (as Views) which serve this purpose.

The dataset provided by AirBnB contains three tables:

**listings** - approximately 3800 unique web listings on the AirBnB, with many details about the properties
**reviews** - approximately 85000 user reviews for those properties, including the full text for each review
**calendar** - approximately 1.4 million observations regarding the price and availability of each property, for each day of the year in 2016

The database structure is straightforward:

![Database Diagram](/term/ERD_airbnb_seattle.png)


### Analytics Plan

The project creates an analytical layer which can be used for general analysis, and several data marts which answer specific questions.


1. The data is loaded into normalized tables. A stored procedure can start the ETL using these tables.
2. The ETL extracts columns which are relevant for analytics.
3. The ETL transforms data from **reviews** and **calendar**. It groups by the listing_id (unique identifer for every property) and performs aggregate calculations. This is particularly helpful for **avg_observed_price**, an observation of the average price for a property as it fluctuates through the year. It is also useful for **avg_availability**, which takes 365 TRUE/FALSE observations and transforms them into one, easy-to-use number.

As an example, see this snapshot of the aggregation on **calendars**:

![creation of avg_availability column](https://github.com/joyce-john/DE1/blob/master/term/screenshots/ETL_calendar_transform.jpg)


4. The extracted and transformed data is loaded into a data warehouse called **property stats**.

5. Data marts are created as Views from **property_stats**.

	



