# Identifying high-usage columns in your User, Booking, and Property table

These columns are the possible candidates to be indexed (In order to improve query performance)
They are the columns used in **WHERE, JOIN, ORDER BY** clauses

### Users Table
We would like to filter users by **email, first_name and last_name**
Hence, these columns need to be indexed

### Bookings Table
We would like to filter bookings by status, and booking_date
Hence, the columns(**status and created_at**) need to be indexed

### properties Table
We would like to filter properties by location
Hence, the columns(**status and created_at**) need to be indexed