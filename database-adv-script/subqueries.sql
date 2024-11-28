-- Correlated and Non-correlated subqueries.

-- A query to find all properties where the average rating is greater than 4.0 using a subquery
SELECT p.property_id, p.location, p.description
FROM properties AS p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews AS r
    WHERE r.property_id = p.property_id
) > 4.0;

-- A correlated subquery to find users who have made more than 3 bookings.
SELECT *
FROM users AS u
WHERE (
    SELECT COUNT(*)
    FROM bookings AS b
    WHERE b.user_id = u.user_id
) > 3;