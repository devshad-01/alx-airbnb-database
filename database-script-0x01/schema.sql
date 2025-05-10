-- Airbnb Clone Database Schema
-- Based on the Entity-Relationship Requirements

-- Note: SQL Server uses UNIQUEIDENTIFIER and NEWID() for UUID functionality
-- No extension needed

-- Create User table
CREATE TABLE "user"
(
    user_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(10) NOT NULL CHECK (role IN ('guest', 'host', 'admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Address table (normalized from Property)
CREATE TABLE "address"
(
    address_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8)
);

-- Create Property table
CREATE TABLE "property"
(
    property_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    host_id UNIQUEIDENTIFIER NOT NULL,
    address_id UNIQUEIDENTIFIER NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES "address"(address_id) ON DELETE CASCADE
);

-- Create Feature table (for property amenities)
CREATE TABLE "feature"
(
    feature_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- Create PropertyFeature junction table
CREATE TABLE "property_feature"
(
    property_id UNIQUEIDENTIFIER NOT NULL,
    feature_id UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (property_id, feature_id),
    FOREIGN KEY (property_id) REFERENCES "property"(property_id) ON DELETE CASCADE,
    FOREIGN KEY (feature_id) REFERENCES "feature"(feature_id) ON DELETE CASCADE
);

-- Create Booking table
CREATE TABLE "booking"
(
    booking_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'canceled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES "property"(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    CHECK (end_date > start_date)
);

-- Create Payment table
CREATE TABLE "payment"
(
    payment_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    booking_id UNIQUEIDENTIFIER NOT NULL UNIQUE,
    -- one-to-one relationship
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')),
    FOREIGN KEY (booking_id) REFERENCES "booking"(booking_id) ON DELETE CASCADE
);

-- Create Review table
CREATE TABLE "review"
(
    review_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    property_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES "property"(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Create Message table
CREATE TABLE "message"
(
    message_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    sender_id UNIQUEIDENTIFIER NOT NULL,
    recipient_id UNIQUEIDENTIFIER NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Create UserProfile table (normalized from User)
CREATE TABLE "user_profile"
(
    profile_id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    user_id UNIQUEIDENTIFIER NOT NULL UNIQUE,
    profile_picture VARCHAR(255),
    bio TEXT,
    preferred_language VARCHAR(50),
    preferred_currency VARCHAR(3),
    notification_preferences NVARCHAR(MAX),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Create indexes for optimized queries
CREATE INDEX idx_property_host_id ON "property"(host_id);
CREATE INDEX idx_property_price ON "property"(price_per_night);
CREATE INDEX idx_booking_user_id ON "booking"(user_id);
CREATE INDEX idx_booking_property_id ON "booking"(property_id);
CREATE INDEX idx_booking_dates ON "booking"(start_date, end_date);
CREATE INDEX idx_review_property_id ON "review"(property_id);
CREATE INDEX idx_review_user_id ON "review"(user_id);
CREATE INDEX idx_message_sender_id ON "message"(sender_id);
CREATE INDEX idx_message_recipient_id ON "message"(recipient_id);
CREATE INDEX idx_address_location ON "address"(city, country);
