-- Correlated and Non-correlated subqueries.

-- A query to find all properties where the average rating is greater than 4.0 using a subquery
SELECT p.property_id, p.location, p.description
FROM properties AS p
WHERE (
    SELECT AVG(r.rating)
    FROM reviews AS r
    WHERE r.property_id = p.property_id
) > 4.0;
