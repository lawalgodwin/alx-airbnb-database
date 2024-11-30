-- This script refactors complex queries to improve performance

-- An initial query that retrieves all bookings along with the user details, property details, and payment details
SELECT b.*, u.*, props.*, p.*
FROM users u
JOIN bookings b ON b.user_id = u.user_id
JOIN properties props ON b.property_id = props.property_id
JOIN payments p ON p.booking_id = b.booking_id;

-- Inspect the query to identify inefficiency
-- EXPLAIN
EXPLAIN
    SELECT b.*, u.*, props.*, p.*
    FROM users u
    JOIN bookings b ON b.user_id = u.user_id
    JOIN properties props ON b.property_id = props.property_id
    JOIN payments p ON p.booking_id = b.booking_id\G;

-- Refactor the query to reduce bandwidth by selecting only required columns
EXPLAIN ANALYZE
    SELECT 
        b.booking_id, 
        CONCAT(u.first_name, " ", u.last_name) AS names, 
        CONCAT(props.name, " ", props.location) AS Property, 
        p.amount
    FROM users u
    JOIN bookings b ON b.user_id = u.user_id
    JOIN properties props ON b.property_id = props.property_id
    JOIN payments p ON p.booking_id = b.booking_id;