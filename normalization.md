## Normalizing My Database Design


Here’s the process for normalizing my AirBnB-like system database to ensure it is in **Third Normal Form (3NF)**.

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
location_id: Foreign Key, references Location(location_id)
pricepernight: DECIMAL, NOT NULL
created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
```

#### **Location Table**
```sql
location_id: Primary Key, UUID
location_name: VARCHAR, UNIQUE, NOT NULL
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
- **Ensure atomicity**: All attributes contain only single values. The schema already complies with this principle.
- **Unique identifiers**: Every table has a Primary Key.

#### **Step 2: Second Normal Form (2NF)**
- **Remove partial dependencies**: Attributes depend on the whole Primary Key, not part of it. The schema meets this criterion because each non-key attribute is fully dependent on the Primary Key.
- **Check for compound keys**: None of the tables use composite keys, so 2NF is already satisfied.

#### **Step 3: Third Normal Form (3NF)**
- **Remove transitive dependencies**: Non-key attributes must depend only on the Primary Key.
  - **Location**: The `location` attribute in the `Property` table could potentially be reused across properties, leading to redundancy. A new `Location` table is introduced with `location_id` and `location_name`, linked to the `Property` table.
  - All other attributes in the schema depend directly on the Primary Key.

---

### **Final Schema**
The schema now adheres to 3NF, ensuring no redundancies or unnecessary dependencies.

--- 

### **Markdown File**

```markdown
# Database Normalization for AirBnB-like System

## Introduction
This document describes the steps taken to normalize the database schema for an AirBnB-like system. The goal is to achieve Third Normal Form (3NF) to minimize redundancy and improve data integrity.

---

## Initial Observations
The original schema was well-structured but had the following potential issues:
1. **Location Redundancy**: The `location` attribute in the `Property` table could be reused across multiple properties, leading to potential duplication.
2. **No Other Violations Identified**: The schema already adhered to the principles of 1NF and 2NF.

---

## Steps to Normalize

### Step 1: First Normal Form (1NF)
- Ensured atomicity: All attributes contained single values.
- Verified unique identifiers: Each table had a Primary Key.

### Step 2: Second Normal Form (2NF)
- Checked for partial dependencies: All non-key attributes were fully dependent on the entire Primary Key.

### Step 3: Third Normal Form (3NF)
- Removed transitive dependencies:
  - **Location**: Extracted `location` into a separate table (`Location`) to prevent redundancy and ensure data reusability.
  
---

## Normalized Schema
### User Table
- Contains user-specific information.

### Property Table
- Linked to the `Location` table to normalize location data.

### Location Table
- Stores unique location data.

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
The schema now complies with 3NF, ensuring minimal redundancy and enhanced data integrity while supporting scalability and maintainability.