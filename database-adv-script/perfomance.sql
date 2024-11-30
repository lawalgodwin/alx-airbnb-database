-- This script refactors complex queries to improve performance

-- An initial query that retrieves all bookings along with the user details, property details, and payment details
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,
    u.user_id AS guest_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight,
    p.host_id,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    users h ON p.host_id = h.user_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed' 
    AND b.start_date >= '2024-01-01' 
    AND b.end_date <= '2024-12-31'
ORDER BY 
    b.created_at DESC;


-- Inspect the query to identify inefficiency
-- EXPLAIN
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    b.created_at AS booking_created_at,
    u.user_id AS guest_id,
    CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
    u.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    p.pricepernight,
    p.host_id,
    CONCAT(h.first_name, ' ', h.last_name) AS host_name,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    bookings b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
JOIN 
    users h ON p.host_id = h.user_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed' 
    AND b.start_date >= '2024-01-01' 
    AND b.end_date <= '2024-12-31'
ORDER BY 
    b.created_at DESC\G;


-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.

CREATE INDEX idx_booking_user ON bookings(user_id);
CREATE INDEX idx_booking_property ON bookings(property_id);
CREATE INDEX idx_booking_filter ON bookings(status, start_date, end_date);
CREATE INDEX idx_payment_booking ON payments(booking_id);
CREATE INDEX idx_property_host ON properties(host_id);


EXPLAIN ANALYZE
    SELECT 
        b.booking_id,
        b.start_date,
        b.end_date,
        b.total_price,
        b.status AS booking_status,
        b.created_at AS booking_created_at,
        u.user_id AS guest_id,
        CONCAT(u.first_name, ' ', u.last_name) AS guest_name,
        u.email AS guest_email,
        p.property_id,
        p.name AS property_name,
        p.location AS property_location,
        pay.payment_id,
        pay.amount AS payment_amount,
        pay.payment_date,
        pay.payment_method
    FROM 
        bookings b
    JOIN 
        users u ON b.user_id = u.user_id
    JOIN 
        properties p ON b.property_id = p.property_id
    LEFT JOIN 
        payments pay ON b.booking_id = pay.booking_id
    WHERE 
        b.status = 'confirmed'
        AND b.start_date >= '2024-01-01'
        AND b.end_date <= '2024-12-31'
    ORDER BY 
        b.created_at DESC;
