# Database Normalization to 3NF - AirBnB Schema

## Original Schema Issues

### 1. First Normal Form (1NF) Violations

- **Composite Attributes**:
  - `location` field in Property table
  - `role`, `status`, and `payment_method` ENUM types
- **Non-Atomic Values**:
  - Single field for location data
  - ENUM types acting as pseudo-reference tables

### 2. Second Normal Form (2NF) Violations

- **Partial Dependencies**:
  - User profile data mixed with authentication data
  - Property features stored denormalized

### 3. Third Normal Form (3NF) Violations

- **Transitive Dependencies**:
  - `total_price` in Booking table (derived from pricepernight and dates)
  - Redundant user data in multiple tables

---

## Normalization Steps

### Step 1: Achieve 1NF - Atomic Values

**1.1 Split Composite Attributes**

```sql
-- Original
Property(location VARCHAR)

-- Normalized
CREATE TABLE Address (
    address_id UUID PRIMARY KEY,
    street VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    postal_code VARCHAR,
    latitude DECIMAL,
    longitude DECIMAL
);
```

**1.2 Replace ENUMs with Reference Tables**

```sql
-- Original: ENUM('guest', 'host', 'admin')
CREATE TABLE UserRole (
    role_id UUID PRIMARY KEY,
    role_name VARCHAR(20) UNIQUE
);

-- Original: ENUM('pending', 'confirmed', 'canceled')
CREATE TABLE BookingStatus (
    status_id UUID PRIMARY KEY,
    status_name VARCHAR(20) UNIQUE
);
```

### Step 2: Achieve 2NF - Remove Partial Dependencies

**2.1 Separate User Authentication and Profile**

```sql
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    email VARCHAR UNIQUE,
    password_hash VARCHAR,
    role_id UUID REFERENCES UserRole
);

CREATE TABLE UserProfile (
    user_id UUID PRIMARY KEY REFERENCES User,
    first_name VARCHAR,
    last_name VARCHAR,
    phone_number VARCHAR
);
```

**2.2 Normalize Property Features**

```sql
CREATE TABLE Feature (
    feature_id UUID PRIMARY KEY,
    feature_name VARCHAR UNIQUE
);

CREATE TABLE PropertyFeature (
    property_id UUID REFERENCES Property,
    feature_id UUID REFERENCES Feature,
    PRIMARY KEY (property_id, feature_id)
);
```

### Step 3: Achieve 3NF - Remove Transitive Dependencies

**3.1 Remove Derived Data**

```sql
-- Original: Booking(total_price)
-- Removed and replaced with view:
CREATE VIEW BookingPricing AS
SELECT booking_id,
       (end_date - start_date) * price_per_night AS total_price
FROM Booking
JOIN Property USING (property_id);
```

**3.2 Normalize Payment Methods**

```sql
-- Original: ENUM('credit_card', 'paypal', 'stripe')
CREATE TABLE PaymentMethod (
    method_id UUID PRIMARY KEY,
    method_name VARCHAR(20) UNIQUE
);
```

## Additional Improvements

**4.1 Review-Booking Relationship**

```sql
-- Original linked to property/user directly
ALTER TABLE Review ADD COLUMN booking_id UUID REFERENCES Booking;
```

**4.2 Spatial Data Normalization**

```sql
ALTER TABLE Address ADD COLUMN geog GEOGRAPHY(POINT,4326);
CREATE INDEX idx_address_geog ON Property USING GIST(geog);
```

## Final Schema Structure

- User
  - UserRole
  - UserProfile
  - Booking
    - BookingStatus
    - Payment
      - PaymentMethod
- Property
  - Address
  - PropertyFeature
    - Feature
  - Availability
- Review
- Message

## Normalization Benefits

- **Reduced Data Redundancy**:

  - Address data stored once per property
  - User roles stored in single reference table

- **Improved Data Integrity**:

  - ENUM values controlled through reference tables
  - Price calculations centralized in view

- **Easier Modifications**:

  - Add new payment methods without schema changes
  - Update user roles without altering multiple tables

- **Better Query Performance**:
  - Spatial indexing for location searches
  - Proper indexing through foreign keys
