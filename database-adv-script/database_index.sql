-- A script that indexes frequently used columns to improve query performance

USE airbnb;

-- index the first_name and last_name columns on the users table
-- DROP INDEX IF EXISTS `idx_names` ON users;
-- CREATE INDEX IF NOT EXISTS `idx_names` ON users(first_name, last_name);
CREATE INDEX idx_names ON users(first_name, last_name);

-- index the status and created_at columns on the bookings table
-- DROP INDEX IF EXISTS `idx_status_and_bookingdate` ON bookings;
-- CREATE INDEX IF NOT EXISTS idx_status_and_bookingdate ON bookings(bookings.status, created_at);
CREATE INDEX idx_status_and_bookingdate ON bookings(status, created_at);

-- index the location column on the properties table
-- DROP INDEX IF EXISTS `idx_location` ON properties;
-- CREATE INDEX IF NOT EXISTS idx_location ON properties(location);
CREATE INDEX idx_location ON properties(location);