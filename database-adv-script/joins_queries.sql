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