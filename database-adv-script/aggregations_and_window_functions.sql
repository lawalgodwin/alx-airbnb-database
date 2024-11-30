-- Using SQL aggregation and window functions to analyze data

-- A query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause
SELECT u.user_id, CONCAT(u.first_name, " ", u.last_name) AS names, COUNT(*) AS number_of_bookings
FROM users AS u
JOIN bookings AS b
ON b.user_id = u.user_id
GROUP BY u.user_id;

-- Using a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received
SELECT
    p.property_id, p.name, p.location,
    COUNT(b.booking_id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS `row_number`,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS `rank`
FROM properties AS p
JOIN bookings AS b
ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY `rank`