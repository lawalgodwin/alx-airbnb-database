-- A script that indexes frequently used columns to improve query performance

USE airbnb;

-- index the first_name and last_name columns on the users table
-- DROP INDEX IF EXISTS `idx_names` ON users;
-- CREATE INDEX IF NOT EXISTS `idx_names` ON users(first_name, last_name);
SELECT ("Before indexing users table.....");
EXPLAIN ANALYZE SELECT * FROM users WHERE first_name = "Alice";
CREATE INDEX idx_names ON users(first_name, last_name);
SELECT ("After indexing users table.....");
EXPLAIN ANALYZE SELECT * FROM users WHERE first_name = "Alice";

-- index the status and created_at columns on the bookings table
-- DROP INDEX IF EXISTS `idx_status_and_bookingdate` ON bookings;
-- CREATE INDEX IF NOT EXISTS idx_status_and_bookingdate ON bookings(bookings.status, created_at);
SELECT ("Before indexing bookings table.....");
EXPLAIN ANALYZE SELECT booking_id, created_at, status FROM bookings WHERE created_at = "2024-11-27 00:29:13" AND status = "pending";
CREATE INDEX idx_status_and_bookingdate ON bookings(status, created_at);
SELECT ("After indexing bookings table.....");
EXPLAIN ANALYZE SELECT booking_id, created_at, status FROM bookings WHERE created_at = "2024-11-27 00:29:13" AND status = "pending";
-- index the location column on the properties table
-- DROP INDEX IF EXISTS `idx_location` ON properties;
-- CREATE INDEX IF NOT EXISTS idx_location ON properties(location);
SELECT ("Before indexing properties table.....");
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = "Miami, FL";
CREATE INDEX idx_location ON properties(location);
SELECT ("After indexing properties table.....");
EXPLAIN ANALYZE SELECT * FROM properties WHERE location = "Miami, FL";