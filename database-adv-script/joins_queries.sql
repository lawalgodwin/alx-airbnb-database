-- Unleashing Advanced Querying Power

-- A query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings

SELECT b.booking_id, b.start_date, b.end_date, CONCAT(u.first_name, " ", u.last_name) AS names, u.email
FROM bookings AS b
INNER JOIN users AS u
ON u.user_id = b.user_id\G;


-- A query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT p.name, p.location, p.pricepernight, r.comment
FROM properties AS p
LEFT JOIN reviews AS r
ON p.property_id = r.property_id\G;

-- A query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT CONCAT(u.first_name, " ", u.last_name) AS names, u.email, b.booking_id, b.start_date, b.end_date
FROM users AS u
LEFT JOIN bookings AS b
ON u.user_id = b.user_id
UNION
SELECT CONCAT(u.first_name, " ", u.last_name) AS names, u.email, b.booking_id, b.start_date, b.end_date
FROm users AS u
RIGHT JOIN bookings AS b
ON u.user_id = b.user_id;

-- NOTE: In mySQL, FULL OUTER is not supported directly
-- But it is equivqlent to the result set of the Combination of LEFT JOIN and RIGHT JOIN, hence the UNION
-- FULL OUTER JOIN = LEFT JOIN + RIGHT JOIN ==> (LEFT JOIN UNION RIGHT JOIN)