# Normalizing the Database design
---

### **Normalized Schema**

#### **User Table**
```sql
user_id: Primary Key, UUID, Indexed
first_name: VARCHAR, NOT NULL
last_name: VARCHAR, NOT NULL
email: VARCHAR, UNIQUE, NOT NULL
password_hash: VARCHAR, NOT NULL
phone_number: VARCHAR, NULL
role: ENUM (guest, host, admin), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
```

#### **Property Table**
```sql
property_id: Primary Key, UUID, Indexed
host_id: Foreign Key, references User(user_id)
name: VARCHAR, NOT NULL
description: TEXT, NOT NULL
location: VARCHAR, NOT NULL
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
```

#### **Booking Table**
```sql
booking_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
start_date: DATE, NOT NULL
end_date: DATE, NOT NULL
total_price: DECIMAL, NOT NULL
status: ENUM (pending, confirmed, canceled), NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
```

#### **Payment Table**
```sql
payment_id: Primary Key, UUID, Indexed
booking_id: Foreign Key, references Booking(booking_id)
amount: DECIMAL, NOT NULL
payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
payment_method: ENUM (credit_card, paypal, stripe), NOT NULL
```

#### **Review Table**
```sql
review_id: Primary Key, UUID, Indexed
property_id: Foreign Key, references Property(property_id)
user_id: Foreign Key, references User(user_id)
rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
comment: TEXT, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
```

#### **Message Table**
```sql
message_id: Primary Key, UUID, Indexed
sender_id: Foreign Key, references User(user_id)
recipient_id: Foreign Key, references User(user_id)
message_body: TEXT, NOT NULL
sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
```

---

### **Normalization Steps**

#### **Step 1: First Normal Form (1NF)**
- **Ensure atomicity**: All attributes contain only single values. The schema complies with this.
- **Unique identifiers**: Every table has a Primary Key.

#### **Step 2: Second Normal Form (2NF)**
- **Remove partial dependencies**: Non-key attributes depend only on the entire Primary Key. The schema meets this criterion since all attributes are fully dependent on their respective Primary Keys.

#### **Step 3: Third Normal Form (3NF)**
- **Remove transitive dependencies**: Non-key attributes must depend only on the Primary Key. 
  - The `location` field remains in the `Property` table because it directly describes the property and does not introduce any redundancy or indirect dependency.

---

### **Final Schema**
The schema remains normalized to **3NF** while keeping the `location` field in the `Property` table.

---

# Database Normalization for AirBnB-like System

## Introduction
This document describes the steps taken to normalize the database schema for an AirBnB-like system. The goal is to achieve Third Normal Form (3NF) to minimize redundancy and improve data integrity.

---

## Observations
1. **Location Field**: The `location` attribute in the `Property` table is directly related to the property and does not require normalization into a separate table. It is left as-is.
2. The schema already adheres to the principles of 1NF and 2NF.


## Steps to Normalize

### Step 1: First Normal Form (1NF)
- Ensured atomicity: All attributes contained single values.
- Verified unique identifiers: Each table had a Primary Key.

### Step 2: Second Normal Form (2NF)
- Verified that non-key attributes depended entirely on the Primary Key.

### Step 3: Third Normal Form (3NF)
- Checked for transitive dependencies:
  - All non-key attributes depend directly on their respective Primary Keys.
  - The `location` field was analyzed and retained in the `Property` table since it does not introduce redundancy or dependency on other attributes.


## Final Schema
### User Table
- Contains user-specific information.

### Property Table
- Includes `location` as a direct property attribute.

### Booking Table
- Manages property bookings by users.

### Payment Table
- Tracks payments for bookings.

### Review Table
- Contains user reviews for properties.

### Message Table
- Handles communication between users.

---

## Conclusion
The schema adheres to 3NF, ensuring minimal redundancy and enhanced data integrity while supporting scalability and maintainability.