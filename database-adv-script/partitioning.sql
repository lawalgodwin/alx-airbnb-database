-- This script implements table partitioning to optimize queries on large datasets.
-- In Mysql, partitioning can only be done at the time of time creation and not on an existing table.

-- Here, we are recreating the bookings table except without the foreign key constraints
CREATE TABLE IF NOT EXISTS booking_partitioned (
    booking_id CHAR(36) NOT NULL,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date), -- Partition key must be part of the primary key
    KEY idx_property_id (property_id), -- Index to facilitate manual integrity checks and optimize joins
    KEY idx_user_id (user_id) -- Index to facilitate manual integrity checks and optimize joins
) 
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p_before_2020 VALUES LESS THAN (2020),
    PARTITION p_2020 VALUES LESS THAN (2021),
    PARTITION p_2021 VALUES LESS THAN (2022),
    PARTITION p_2022 VALUES LESS THAN (2023),
    PARTITION p_2023 VALUES LESS THAN (2024),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- migrate the bookings data to the newly created partition
INSERT INTO booking_partitioned
SELECT * FROM bookings;

-- query the partitioned table and analyse for effeciency
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
    p.property_id,
    p.name AS property_name,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.payment_method
FROM 
    booking_partitioned b
JOIN 
    users u ON b.user_id = u.user_id
JOIN 
    properties p ON b.property_id = p.property_id
LEFT JOIN 
    payments pay ON b.booking_id = pay.booking_id
WHERE 
    b.status = 'confirmed'
    AND b.start_date >= '2024-01-01'
    AND b.start_date <= '2024-12-31'
ORDER BY 
    b.created_at DESC;

