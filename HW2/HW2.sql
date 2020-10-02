USE birdstrikes;

-- Exercise 1: Tennessee
SELECT state FROM birdstrikes LIMIT 144,1;

-- Exercise 2: 2000-04-18
SELECT flight_date FROM birdstrikes ORDER BY flight_date DESC LIMIT 1;

-- Exercise 3: 5345
SELECT DISTINCT cost FROM birdstrikes ORDER BY cost DESC LIMIT 49,1;

-- Exercise 4: ""
-- it's an empty string
SELECT state FROM birdstrikes WHERE state IS NOT NULL AND bird_size IS NOT NULL LIMIT 1,1;

-- Exercise 5:

