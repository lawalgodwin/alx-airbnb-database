-- Unleashing Advanced Querying Power

-- query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings

SELECT b.*, u.*
FROM bookings AS b
INNER JOIN users AS u
ON u.user_id = b.user_id\G;
