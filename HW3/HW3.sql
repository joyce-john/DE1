USE birdstrikes;

-- Exercise 1
SELECT id, airline, speed, IF(( speed < 100 OR speed IS NULL ), 'LOW SPEED', 'HIGH SPEED') AS speed_category FROM birdstrikes ORDER BY speed_category;

-- Exercise 2: 3
SELECT COUNT(DISTINCT(aircraft)) FROM birdstrikes;

-- Exercise 3: 9
SELECT MIN(speed) FROM birdstrikes WHERE aircraft LIKE 'H%';

-- Exercise 4: taxi
SELECT phase_of_flight, COUNT(*) AS count FROM birdstrikes GROUP BY phase_of_flight;

-- Exercise 5: 54673
SELECT phase_of_flight, round(avg(cost)) AS round_avg_cost FROM birdstrikes GROUP BY phase_of_flight ORDER BY round_avg_cost DESC;

-- Exercise 6: 2862.500
SELECT AVG(speed) AS avg_speed, state FROM birdstrikes WHERE LENGTH(state) < 5 AND state != '' GROUP BY state ORDER BY avg_speed DESC;