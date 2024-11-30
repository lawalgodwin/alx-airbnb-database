-- A script that indexes frequently used columns to improve query performance

USE airbnb;

-- index the first_name and last_name columns on the users table
CREATE INDEX idx_names ON users(first_name, last_name);