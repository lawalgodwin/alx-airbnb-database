-- Using SQL aggregation and window functions to analyze data

-- A query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause
SELECT u.user_id, CONCAT(u.first_name, " ", u.last_name) AS names, COUNT(*) AS number_of_bookings
FROM users AS u
JOIN bookings AS b
ON b.user_id = u.user_id
GROUP BY u.user_id;