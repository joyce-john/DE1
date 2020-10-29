-- create and use the schema
DROP SCHEMA IF EXISTS airbnb;
CREATE SCHEMA airbnb;
USE airbnb;

-- create schema for listings, which has 92 columns
-- primary key: id
DROP TABLE IF EXISTS listings;

-- columns marked with a * require a SET COLUMN = NULLIF(@VAR = '') statement + a @v_column variable import...
-- ...during the LOAD DATA IN FILE call
CREATE TABLE listings
(id INT,
listing_url VARCHAR(255),
scrape_id BIGINT,
last_scraped DATE,
name VARCHAR(255),
summary MEDIUMTEXT,
space MEDIUMTEXT,
description MEDIUMTEXT,
experiences_offered TEXT,
neighborhood_overview TEXT,
notes TEXT,
transit TEXT,
thumbnail_url TEXT,
medium_url TEXT,
picture_url TEXT,
xl_picture_url TEXT,
host_id BIGINT,
host_url TEXT,
host_name VARCHAR(255),
host_since DATE, -- *
host_location VARCHAR(255),
host_about TEXT,
host_response_time VARCHAR(255),
host_response_rate VARCHAR(5), -- due to entries such as "N/A"
host_acceptance_rate VARCHAR(5), -- due to entries such as "N/A"
host_is_superhost VARCHAR(1),
host_thumbnail_url TEXT,
host_picture_url TEXT,
host_neighbourhood VARCHAR(255),
host_listings_count INT, -- *
host_total_listings_count INT, -- *
host_verifications TEXT,
host_has_profile_pic VARCHAR(1),
host_identity_verified VARCHAR(1),
street VARCHAR(255),
neighbourhood VARCHAR(255),
neighbourhood_cleansed VARCHAR(255),
neighbourhood_group_cleansed VARCHAR(255),
city VARCHAR(255),
state VARCHAR(255),
zipcode VARCHAR(255),
market VARCHAR(255),
smart_location VARCHAR(255),
country_code VARCHAR(255),
country VARCHAR(255),
latitude DOUBLE, 
longitude DOUBLE, 
is_location_exact VARCHAR(1),
property_type VARCHAR(255),
room_type VARCHAR(255),
accommodates INT,
bathrooms DOUBLE, -- DOUBLE later to allow for values like 3.5 *
bedrooms INT, -- *
beds INT, -- *
bed_type VARCHAR(255),
amenities TEXT,
square_feet VARCHAR(255), -- VARCHAR accomodates entries which have the string "NA"
price VARCHAR(255), -- VARCHAR accomodates $ sign
weekly_price DOUBLE,
monthly_price VARCHAR(255),
security_deposit VARCHAR(255),
cleaning_fee VARCHAR(255),
guests_included INT,
extra_people VARCHAR(255),
minimum_nights INT,
maximum_nights INT,
calendar_updated VARCHAR(255),
has_availability VARCHAR(1),
availability_30 INT,
availability_60 INT,
availability_90 INT,
availability_365 INT,
calendar_last_scraped DATE,
number_of_reviews INT,
first_review DATE, -- *
last_review DATE,  -- *
review_scores_rating INT, -- *
review_scores_accuracy INT, -- *
review_scores_cleanliness INT, -- *
review_scores_checkin INT, -- *
review_scores_communication INT, -- *
review_scores_location INT, -- *
review_scores_value INT, -- *
requires_license VARCHAR(1),
license VARCHAR(255),
jurisdiction_names VARCHAR(255),
instant_bookable VARCHAR(1),
cancellation_policy VARCHAR(255),
require_guest_profile_picture VARCHAR(1),
require_guest_phone_verification VARCHAR(1),
calculated_host_listings_count INT,
reviews_per_month DECIMAL(10,2)); -- *

truncate listings;
-- load data into listings table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\listings.csv'
INTO TABLE listings
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' -- some user-submitted text contains commas
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,listing_url,scrape_id,last_scraped,name,summary,space,description,experiences_offered,neighborhood_overview,notes,transit,thumbnail_url,medium_url,picture_url,xl_picture_url,host_id,host_url,host_name,@v_host_since,host_location,host_about,host_response_time,host_response_rate,host_acceptance_rate,host_is_superhost,host_thumbnail_url,host_picture_url,host_neighbourhood,@v_host_listings_count,@v_host_total_listings_count,host_verifications,host_has_profile_pic,host_identity_verified,street,neighbourhood,neighbourhood_cleansed,neighbourhood_group_cleansed,city,state,zipcode,market,smart_location,country_code,country,latitude,longitude,is_location_exact,property_type,room_type,accommodates,@v_bathrooms,@v_bedrooms,@v_beds,bed_type,amenities,square_feet,price,@v_weekly_price,monthly_price,security_deposit,cleaning_fee,guests_included,extra_people,minimum_nights,maximum_nights,calendar_updated,has_availability,availability_30,availability_60,availability_90,availability_365,calendar_last_scraped,number_of_reviews,@v_first_review,@v_last_review,@v_review_scores_rating,@v_review_scores_accuracy,@v_review_scores_cleanliness,@v_review_scores_checkin,@v_review_scores_communication,@v_review_scores_location,@v_review_scores_value,requires_license,license,jurisdiction_names,instant_bookable,cancellation_policy,require_guest_profile_picture,require_guest_phone_verification,calculated_host_listings_count,@v_reviews_per_month
)
SET 
host_since = NULLIF(@v_host_since, ''),
host_listings_count = NULLIF(@v_host_listings_count, ''),
host_total_listings_count = NULLIF(@v_host_total_listings_count, ''),
bathrooms = NULLIF(@v_bathrooms, ''),
bedrooms = NULLIF(@v_bedrooms, ''),
beds = NULLIF(@v_beds, ''),

weekly_price = IF(@v_weekly_price = '', NULL,  CAST(REPLACE(SUBSTRING(@v_weekly_price, 2), ",", "") AS DECIMAL(10,2) )),

first_review = NULLIF(@v_first_review, ''),
last_review = NULLIF(@v_last_review, ''),
review_scores_rating = NULLIF(@v_review_scores_rating, ''),
review_scores_accuracy = NULLIF(@v_review_scores_accuracy, ''),
review_scores_cleanliness = NULLIF(@v_review_scores_cleanliness, ''),
review_scores_checkin = NULLIF(@v_review_scores_checkin, ''),
review_scores_communication = NULLIF(@v_review_scores_communication, ''),
review_scores_location = NULLIF(@v_review_scores_location, ''),
review_scores_value = NULLIF(@v_review_scores_value, ''),
reviews_per_month = NULLIF(@v_reviews_per_month, '')
;

SELECT weekly_price FROM listings;

-- create reviews table
-- linking vars: listing_id, id
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews
(listing_id INT,
id INT,
date DATE,
reviewer_id INT,
reviewer_name VARCHAR(255),
comments TEXT);

-- load reviews data into table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\reviews.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' -- some user-submitted text contains commas
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(listing_id,id,date,reviewer_id,reviewer_name,comments);

-- create calendar table
-- linking vars: listing_id
DROP TABLE IF EXISTS calendar;

CREATE TABLE calendar
(listing_id INT,
date DATE,
available VARCHAR(1),
price VARCHAR(255));

-- load data into calendar table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\calendar.csv'
INTO TABLE calendar
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' -- some user-submitted text contains commas
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(listing_id,date,available,price);

SHOW TABLES;
