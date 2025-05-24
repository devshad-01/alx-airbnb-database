-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Reference Tables
CREATE TABLE user_role (
    role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE booking_status (
    status_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    status_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE payment_method (
    method_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    method_name VARCHAR(20) UNIQUE NOT NULL
);

-- Core Tables
CREATE TABLE "user" (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id UUID NOT NULL REFERENCES user_role(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_profile (
    user_id UUID PRIMARY KEY REFERENCES "user"(user_id),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20),
    profile_picture_url VARCHAR(255),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE address (
    address_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    geog GEOGRAPHY(POINT, 4326)
);

CREATE TABLE property (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    host_id UUID NOT NULL REFERENCES "user"(user_id),
    address_id UUID NOT NULL REFERENCES address(address_id),
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL CHECK (price_per_night > 0),
    max_guests INT NOT NULL CHECK (max_guests > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Features System
CREATE TABLE feature (
    feature_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    feature_name VARCHAR(100) UNIQUE NOT NULL,
    icon VARCHAR(50)
);

CREATE TABLE property_feature (
    property_id UUID REFERENCES property(property_id),
    feature_id UUID REFERENCES feature(feature_id),
    PRIMARY KEY (property_id, feature_id)
);

-- Booking System
CREATE TABLE booking (
    booking_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES property(property_id),
    user_id UUID NOT NULL REFERENCES "user"(user_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price > 0),
    status_id UUID NOT NULL REFERENCES booking_status(status_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (end_date > start_date)
);

-- Payment System
CREATE TABLE payment (
    payment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL REFERENCES booking(booking_id),
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id UUID NOT NULL REFERENCES payment_method(method_id)
);

-- Review System
CREATE TABLE review (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES property(property_id),
    user_id UUID NOT NULL REFERENCES "user"(user_id),
    booking_id UUID REFERENCES booking(booking_id),
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Availability System
CREATE TABLE availability (
    property_id UUID REFERENCES property(property_id),
    date DATE NOT NULL,
    is_available BOOLEAN NOT NULL DEFAULT true,
    special_price DECIMAL(10,2),
    PRIMARY KEY (property_id, date)
);

-- Messaging System
CREATE TABLE conversation (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user1_id UUID NOT NULL REFERENCES "user"(user_id),
    user2_id UUID NOT NULL REFERENCES "user"(user_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (user1_id <> user2_id)
);

CREATE TABLE message (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES conversation(conversation_id),
    sender_id UUID NOT NULL REFERENCES "user"(user_id),
    recipient_id UUID NOT NULL REFERENCES "user"(user_id),
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP
);

-- Indexes
CREATE INDEX idx_address_geog ON address USING GIST(geog);
CREATE INDEX idx_booking_dates ON booking(start_date, end_date);
CREATE INDEX idx_user_email ON "user"(email);
CREATE INDEX idx_property_price ON property(price_per_night);
CREATE INDEX idx_availability_date ON availability(date);

-- View for calculated booking price
CREATE VIEW booking_pricing AS
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    p.price_per_night,
    (b.end_date - b.start_date) * p.price_per_night AS total_price
FROM booking b
JOIN property p USING (property_id);

-- Initialize Reference Data
INSERT INTO user_role (role_name) VALUES 
    ('guest'), ('host'), ('admin');

INSERT INTO booking_status (status_name) VALUES 
    ('pending'), ('confirmed'), ('canceled');

INSERT INTO payment_method (method_name) VALUES 
    ('credit_card'), ('paypal'), ('stripe');