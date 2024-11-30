# Optimize Complex Queries
Refactoring complex queries to improve performance

### Inefficiency 1: Too much bandwidth consumption
The initial query retrieves all bookings along with the user details, property details, and payment details
This has the tendency to consume a lot of bandwidth.
The solution is to select only the needed columns