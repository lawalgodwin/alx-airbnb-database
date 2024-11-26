-- An SQL scripts to populate the database with sample data.

-- Insert sample users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('1a2b3c4d-5678-90ab-cdef-1234567890ab', 'Alice', 'Smith', 'alice@example.com', 'hashed_password1', '1234567890', 'guest', NOW()),
    ('2b3c4d5e-6789-01bc-def1-2345678901bc', 'Bob', 'Johnson', 'bob@example.com', 'hashed_password2', '0987654321', 'host', NOW()),
    ('3c4d5e6f-7890-12cd-ef12-3456789012cd', 'Charlie', 'Brown', 'charlie@example.com', 'hashed_password3', '1122334455', 'admin', NOW());

-- Insert sample properties
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
    ('1a1a1a1a-1111-1111-1111-111111111111', '2b3c4d5e-6789-01bc-def1-2345678901bc', 'Ocean View Apartment', 'A beautiful apartment overlooking the ocean.', 'Miami, FL', 200.00, NOW(), NOW()),
    ('2b2b2b2b-2222-2222-2222-222222222222', '2b3c4d5e-6789-01bc-def1-2345678901bc', 'Mountain Retreat', 'A cozy cabin in the mountains.', 'Denver, CO', 150.00, NOW(), NOW());

-- Insert sample bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('1c1c1c1c-3333-3333-3333-333333333333', '1a1a1a1a-1111-1111-1111-111111111111', '1a2b3c4d-5678-90ab-cdef-1234567890ab', '2024-12-01', '2024-12-05', 800.00, 'confirmed', NOW()),
    ('2c2c2c2c-4444-4444-4444-444444444444', '2b2b2b2b-2222-2222-2222-222222222222', '1a2b3c4d-5678-90ab-cdef-1234567890ab', '2024-12-10', '2024-12-15', 750.00, 'pending', NOW());

-- Insert sample payments
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('1d1d1d1d-5555-5555-5555-555555555555', '1c1c1c1c-3333-3333-3333-333333333333', 800.00, NOW(), 'credit_card'),
    ('2d2d2d2d-6666-6666-6666-666666666666', '2c2c2c2c-4444-4444-4444-444444444444', 750.00, NOW(), 'paypal');

-- Insert sample reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('1e1e1e1e-7777-7777-7777-777777777777', '1a1a1a1a-1111-1111-1111-111111111111', '1a2b3c4d-5678-90ab-cdef-1234567890ab', 5, 'Amazing place! Highly recommend.', NOW()),
    ('2e2e2e2e-8888-8888-8888-888888888888', '2b2b2b2b-2222-2222-2222-222222222222', '1a2b3c4d-5678-90ab-cdef-1234567890ab', 4, 'Very comfortable and relaxing.', NOW());

-- Insert sample messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('1f1f1f1f-9999-9999-9999-999999999999', '1a2b3c4d-5678-90ab-cdef-1234567890ab', '2b3c4d5e-6789-01bc-def1-2345678901bc', 'Hello, is the Ocean View Apartment available for these dates?', NOW()),
    ('2f2f2f2f-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '2b3c4d5e-6789-01bc-def1-2345678901bc', '1a2b3c4d-5678-90ab-cdef-1234567890ab', 'Yes, it is available. Let me know if you want to proceed with booking.', NOW());
