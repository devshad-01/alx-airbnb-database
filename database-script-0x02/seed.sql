-- =====================================================
-- Airbnb Database Seeding Script
-- =====================================================
-- This script populates the database with realistic sample data
-- Run this after the schema has been created

-- Clear existing data (optional - uncomment if needed)
-- TRUNCATE TABLE message, conversation, availability, review, payment, booking, property_feature, property, address, user_profile, "user", feature, payment_method, booking_status, user_role CASCADE;

-- Get reference table IDs (these should already exist from schema)
-- We'll use these UUIDs in our INSERT statements

-- =====================================================
-- USERS DATA
-- =====================================================

-- Insert sample users
INSERT INTO "user" (user_id, email, password_hash, role_id) VALUES 
-- Guests
('550e8400-e29b-41d4-a716-446655440001', 'john.doe@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'guest')),
('550e8400-e29b-41d4-a716-446655440002', 'jane.smith@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'guest')),
('550e8400-e29b-41d4-a716-446655440003', 'mike.johnson@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'guest')),
('550e8400-e29b-41d4-a716-446655440004', 'sarah.wilson@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'guest')),
('550e8400-e29b-41d4-a716-446655440005', 'alex.brown@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'guest')),

-- Hosts
('550e8400-e29b-41d4-a716-446655440010', 'lisa.host@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'host')),
('550e8400-e29b-41d4-a716-446655440011', 'david.property@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'host')),
('550e8400-e29b-41d4-a716-446655440012', 'maria.rentals@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'host')),
('550e8400-e29b-41d4-a716-446655440013', 'robert.homes@email.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'host')),

-- Admin
('550e8400-e29b-41d4-a716-446655440020', 'admin@airbnb.com', '$2a$12$LQv3c1yqBwkvuGZG.Gy.0OVXVwTNz5ug1RaYE5vR1vQyJ6qvJ6qvJ', (SELECT role_id FROM user_role WHERE role_name = 'admin'));

-- Insert user profiles
INSERT INTO user_profile (user_id, first_name, last_name, phone_number, profile_picture_url) VALUES 
-- Guest profiles
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Doe', '+1-555-0101', 'https://example.com/profiles/john_doe.jpg'),
('550e8400-e29b-41d4-a716-446655440002', 'Jane', 'Smith', '+1-555-0102', 'https://example.com/profiles/jane_smith.jpg'),
('550e8400-e29b-41d4-a716-446655440003', 'Mike', 'Johnson', '+1-555-0103', 'https://example.com/profiles/mike_johnson.jpg'),
('550e8400-e29b-41d4-a716-446655440004', 'Sarah', 'Wilson', '+1-555-0104', 'https://example.com/profiles/sarah_wilson.jpg'),
('550e8400-e29b-41d4-a716-446655440005', 'Alex', 'Brown', '+1-555-0105', 'https://example.com/profiles/alex_brown.jpg'),

-- Host profiles
('550e8400-e29b-41d4-a716-446655440010', 'Lisa', 'Anderson', '+1-555-0110', 'https://example.com/profiles/lisa_anderson.jpg'),
('550e8400-e29b-41d4-a716-446655440011', 'David', 'Chen', '+1-555-0111', 'https://example.com/profiles/david_chen.jpg'),
('550e8400-e29b-41d4-a716-446655440012', 'Maria', 'Rodriguez', '+1-555-0112', 'https://example.com/profiles/maria_rodriguez.jpg'),
('550e8400-e29b-41d4-a716-446655440013', 'Robert', 'Taylor', '+1-555-0113', 'https://example.com/profiles/robert_taylor.jpg'),

-- Admin profile
('550e8400-e29b-41d4-a716-446655440020', 'System', 'Administrator', '+1-555-0120', 'https://example.com/profiles/admin.jpg');

-- =====================================================
-- ADDRESSES DATA
-- =====================================================

INSERT INTO address (address_id, street, city, state, country, postal_code, latitude, longitude, geog) VALUES 
('650e8400-e29b-41d4-a716-446655440001', '123 Ocean Drive', 'Miami', 'Florida', 'USA', '33139', 25.7617, -80.1918, ST_GeogFromText('POINT(-80.1918 25.7617)')),
('650e8400-e29b-41d4-a716-446655440002', '456 Broadway', 'New York', 'New York', 'USA', '10013', 40.7589, -73.9851, ST_GeogFromText('POINT(-73.9851 40.7589)')),
('650e8400-e29b-41d4-a716-446655440003', '789 Golden Gate Ave', 'San Francisco', 'California', 'USA', '94102', 37.7749, -122.4194, ST_GeogFromText('POINT(-122.4194 37.7749)')),
('650e8400-e29b-41d4-a716-446655440004', '321 Hollywood Blvd', 'Los Angeles', 'California', 'USA', '90028', 34.0522, -118.2437, ST_GeogFromText('POINT(-118.2437 34.0522)')),
('650e8400-e29b-41d4-a716-446655440005', '654 Music Row', 'Nashville', 'Tennessee', 'USA', '37203', 36.1627, -86.7816, ST_GeogFromText('POINT(-86.7816 36.1627)')),
('650e8400-e29b-41d4-a716-446655440006', '987 Lake Shore Dr', 'Chicago', 'Illinois', 'USA', '60611', 41.8781, -87.6298, ST_GeogFromText('POINT(-87.6298 41.8781)')),
('650e8400-e29b-41d4-a716-446655440007', '147 Freedom Trail', 'Boston', 'Massachusetts', 'USA', '02108', 42.3601, -71.0589, ST_GeogFromText('POINT(-71.0589 42.3601)')),
('650e8400-e29b-41d4-a716-446655440008', '258 Cherry Blossom Ln', 'Seattle', 'Washington', 'USA', '98101', 47.6062, -122.3321, ST_GeogFromText('POINT(-122.3321 47.6062)')),
('650e8400-e29b-41d4-a716-446655440009', '369 Peachtree St', 'Atlanta', 'Georgia', 'USA', '30309', 33.7490, -84.3880, ST_GeogFromText('POINT(-84.3880 33.7490)')),
('650e8400-e29b-41d4-a716-446655440010', '741 River Walk', 'Austin', 'Texas', 'USA', '78701', 30.2672, -97.7431, ST_GeogFromText('POINT(-97.7431 30.2672)'));

-- =====================================================
-- FEATURES DATA
-- =====================================================

INSERT INTO feature (feature_id, feature_name, icon) VALUES 
('750e8400-e29b-41d4-a716-446655440001', 'WiFi', 'wifi'),
('750e8400-e29b-41d4-a716-446655440002', 'Kitchen', 'kitchen'),
('750e8400-e29b-41d4-a716-446655440003', 'Air Conditioning', 'ac'),
('750e8400-e29b-41d4-a716-446655440004', 'Pool', 'pool'),
('750e8400-e29b-41d4-a716-446655440005', 'Parking', 'parking'),
('750e8400-e29b-41d4-a716-446655440006', 'Pet Friendly', 'pet'),
('750e8400-e29b-41d4-a716-446655440007', 'Gym', 'gym'),
('750e8400-e29b-41d4-a716-446655440008', 'Balcony', 'balcony'),
('750e8400-e29b-41d4-a716-446655440009', 'Hot Tub', 'hot-tub'),
('750e8400-e29b-41d4-a716-446655440010', 'Beach Access', 'beach');

-- =====================================================
-- PROPERTIES DATA
-- =====================================================

INSERT INTO property (property_id, host_id, address_id, name, description, price_per_night, max_guests) VALUES 
('450e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440001', 'Luxury Beachfront Condo', 'Stunning oceanfront condominium with panoramic views of Miami Beach. Features modern amenities, private balcony, and direct beach access. Perfect for couples or small families looking for a luxurious getaway.', 250.00, 4),
('450e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440002', 'Manhattan Studio Loft', 'Chic studio apartment in the heart of SoHo. Walking distance to restaurants, galleries, and shopping. Modern furnishings with exposed brick walls and high ceilings. Ideal for business travelers or city explorers.', 180.00, 2),
('450e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', '650e8400-e29b-41d4-a716-446655440003', 'Victorian House SF', 'Beautiful restored Victorian home in Pacific Heights. Three bedrooms, two baths, with Golden Gate Bridge views. Features original hardwood floors, modern kitchen, and private garden. Perfect for families.', 320.00, 6),
('450e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440013', '650e8400-e29b-41d4-a716-446655440004', 'Hollywood Hills Retreat', 'Modern hilltop home with city views and infinity pool. Four bedrooms, three baths, gourmet kitchen, and entertainment area. Celebrity neighborhood with privacy and luxury amenities.', 450.00, 8),
('450e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440005', 'Nashville Music Row Apartment', 'Stylish apartment in the heart of Music City. Two bedrooms with music-themed decor, walking distance to famous venues. Perfect for music lovers and those exploring Nashville nightlife.', 140.00, 4),
('450e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440006', 'Chicago Lakefront Penthouse', 'Luxury penthouse with stunning Lake Michigan views. Three bedrooms, chef kitchen, private terrace. Located in prestigious Gold Coast neighborhood with world-class dining and shopping nearby.', 380.00, 6),
('450e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440012', '650e8400-e29b-41d4-a716-446655440007', 'Historic Boston Brownstone', 'Charming 19th-century brownstone near Boston Common. Three floors, four bedrooms, original features with modern updates. Rich history meets contemporary comfort in Americas walking city.', 280.00, 8),
('450e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440013', '650e8400-e29b-41d4-a716-446655440008', 'Seattle Waterfront Cottage', 'Cozy cottage with Puget Sound views. Two bedrooms, fireplace, private deck. Minutes from Pike Place Market and downtown attractions. Perfect blend of urban convenience and waterfront tranquility.', 200.00, 4),
('450e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440010', '650e8400-e29b-41d4-a716-446655440009', 'Atlanta Midtown Loft', 'Industrial loft in trendy Midtown district. Open floor plan, exposed brick, modern amenities. Walking distance to restaurants, parks, and cultural attractions. Great for business or leisure stays.', 160.00, 4),
('450e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440011', '650e8400-e29b-41d4-a716-446655440010', 'Austin River House', 'Unique house on Lady Bird Lake with private dock. Three bedrooms, outdoor living space, kayak access. Experience Austin from the water while being minutes from downtown music scene.', 300.00, 6);

-- =====================================================
-- PROPERTY FEATURES DATA
-- =====================================================

INSERT INTO property_feature (property_id, feature_id) VALUES 
-- Luxury Beachfront Condo features
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440003'), -- AC
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440004'), -- Pool
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440005'), -- Parking
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440008'), -- Balcony
('450e8400-e29b-41d4-a716-446655440001', '750e8400-e29b-41d4-a716-446655440010'), -- Beach Access

-- Manhattan Studio Loft features
('450e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440002', '750e8400-e29b-41d4-a716-446655440003'), -- AC

-- Victorian House SF features
('450e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440005'), -- Parking
('450e8400-e29b-41d4-a716-446655440003', '750e8400-e29b-41d4-a716-446655440006'), -- Pet Friendly

-- Hollywood Hills Retreat features
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440003'), -- AC
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440004'), -- Pool
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440005'), -- Parking
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440007'), -- Gym
('450e8400-e29b-41d4-a716-446655440004', '750e8400-e29b-41d4-a716-446655440009'), -- Hot Tub

-- Add features for remaining properties (abbreviated for space)
('450e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440003'), -- AC
('450e8400-e29b-41d4-a716-446655440005', '750e8400-e29b-41d4-a716-446655440005'), -- Parking

('450e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440003'), -- AC
('450e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440007'), -- Gym
('450e8400-e29b-41d4-a716-446655440006', '750e8400-e29b-41d4-a716-446655440008'), -- Balcony

('450e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440007', '750e8400-e29b-41d4-a716-446655440005'), -- Parking

('450e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440008', '750e8400-e29b-41d4-a716-446655440008'), -- Balcony

('450e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440003'), -- AC
('450e8400-e29b-41d4-a716-446655440009', '750e8400-e29b-41d4-a716-446655440007'), -- Gym

('450e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440001'), -- WiFi
('450e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440002'), -- Kitchen
('450e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440005'), -- Parking
('450e8400-e29b-41d4-a716-446655440010', '750e8400-e29b-41d4-a716-446655440008'); -- Balcony

-- =====================================================
-- BOOKINGS DATA
-- =====================================================

INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status_id) VALUES 
-- Confirmed bookings
('350e8400-e29b-41d4-a716-446655440001', '450e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '2024-03-15', '2024-03-20', 1250.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),
('350e8400-e29b-41d4-a716-446655440002', '450e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '2024-04-10', '2024-04-13', 540.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),
('350e8400-e29b-41d4-a716-446655440003', '450e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '2024-05-05', '2024-05-12', 2240.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),

-- Pending bookings
('350e8400-e29b-41d4-a716-446655440004', '450e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', '2024-06-01', '2024-06-05', 1800.00, (SELECT status_id FROM booking_status WHERE status_name = 'pending')),
('350e8400-e29b-41d4-a716-446655440005', '450e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', '2024-06-15', '2024-06-18', 420.00, (SELECT status_id FROM booking_status WHERE status_name = 'pending')),

-- Canceled booking
('350e8400-e29b-41d4-a716-446655440006', '450e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', '2024-04-20', '2024-04-25', 1900.00, (SELECT status_id FROM booking_status WHERE status_name = 'canceled')),

-- More confirmed bookings
('350e8400-e29b-41d4-a716-446655440007', '450e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '2024-07-01', '2024-07-08', 1960.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),
('350e8400-e29b-41d4-a716-446655440008', '450e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '2024-08-10', '2024-08-15', 1000.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),
('350e8400-e29b-41d4-a716-446655440009', '450e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', '2024-09-05', '2024-09-09', 640.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')),
('350e8400-e29b-41d4-a716-446655440010', '450e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', '2024-10-12', '2024-10-16', 1200.00, (SELECT status_id FROM booking_status WHERE status_name = 'confirmed'));

-- =====================================================
-- PAYMENTS DATA
-- =====================================================

INSERT INTO payment (payment_id, booking_id, amount, payment_date, method_id) VALUES 
-- Payments for confirmed bookings
('250e8400-e29b-41d4-a716-446655440001', '350e8400-e29b-41d4-a716-446655440001', 1250.00, '2024-03-10 10:30:00', (SELECT method_id FROM payment_method WHERE method_name = 'credit_card')),
('250e8400-e29b-41d4-a716-446655440002', '350e8400-e29b-41d4-a716-446655440002', 540.00, '2024-04-05 14:22:00', (SELECT method_id FROM payment_method WHERE method_name = 'paypal')),
('250e8400-e29b-41d4-a716-446655440003', '350e8400-e29b-41d4-a716-446655440003', 2240.00, '2024-04-30 09:15:00', (SELECT method_id FROM payment_method WHERE method_name = 'stripe')),
('250e8400-e29b-41d4-a716-446655440007', '350e8400-e29b-41d4-a716-446655440007', 1960.00, '2024-06-25 16:45:00', (SELECT method_id FROM payment_method WHERE method_name = 'credit_card')),
('250e8400-e29b-41d4-a716-446655440008', '350e8400-e29b-41d4-a716-446655440008', 1000.00, '2024-08-05 11:30:00', (SELECT method_id FROM payment_method WHERE method_name = 'paypal')),
('250e8400-e29b-41d4-a716-446655440009', '350e8400-e29b-41d4-a716-446655440009', 640.00, '2024-09-01 13:20:00', (SELECT method_id FROM payment_method WHERE method_name = 'stripe')),
('250e8400-e29b-41d4-a716-446655440010', '350e8400-e29b-41d4-a716-446655440010', 1200.00, '2024-10-08 10:15:00', (SELECT method_id FROM payment_method WHERE method_name = 'credit_card'));

-- =====================================================
-- REVIEWS DATA
-- =====================================================

INSERT INTO review (review_id, property_id, user_id, booking_id, rating, comment) VALUES 
('150e8400-e29b-41d4-a716-446655440001', '450e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '350e8400-e29b-41d4-a716-446655440001', 5, 'Absolutely amazing stay! The ocean view was breathtaking and the condo was immaculate. Lisa was an exceptional host who provided excellent recommendations for local restaurants. The beach access made our vacation perfect. Will definitely book again!'),

('150e8400-e29b-41d4-a716-446655440002', '450e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '350e8400-e29b-41d4-a716-446655440002', 4, 'Great location in SoHo with easy access to everything NYC has to offer. The studio was clean and modern, though a bit small for extended stays. David was responsive and helpful throughout. Perfect for a short city break.'),

('150e8400-e29b-41d4-a716-446655440003', '450e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '350e8400-e29b-41d4-a716-446655440003', 5, 'The Victorian house exceeded all expectations! Beautiful architecture with modern amenities. The Golden Gate Bridge views from the living room were spectacular. Maria provided thoughtful touches like fresh flowers and local wine. Highly recommend for families visiting SF.'),

('150e8400-e29b-41d4-a716-446655440004', '450e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', '350e8400-e29b-41d4-a716-446655440007', 5, 'Stunning historic brownstone in the heart of Boston! The property beautifully blends original character with modern comfort. Walking distance to all major attractions and excellent restaurants. Maria was incredibly accommodating and provided great local insights.'),

('150e8400-e29b-41d4-a716-446655440005', '450e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', '350e8400-e29b-41d4-a716-446655440008', 4, 'Charming cottage with lovely water views. The location near Pike Place Market was perfect for exploring Seattle. The property was cozy and well-equipped. Robert was a great host with quick responses to questions. Only minor issue was street noise at night.'),

('150e8400-e29b-41d4-a716-446655440006', '450e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', '350e8400-e29b-41d4-a716-446655440009', 4, 'Modern loft in trendy Midtown Atlanta. Great for business travel with good workspace and fast WiFi. Walking distance to restaurants and nightlife. Lisa provided excellent check-in instructions and local recommendations. Would stay again for future Atlanta visits.'),

('150e8400-e29b-41d4-a716-446655440007', '450e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', '350e8400-e29b-41d4-a716-446655440010', 5, 'Unique lakeside experience in Austin! The private dock and kayak access made this stay special. House was spacious and well-appointed. David was an excellent communicator and provided great tips for exploring Austin music scene. Perfect blend of nature and city access.');

-- =====================================================
-- AVAILABILITY DATA
-- =====================================================

-- Insert availability for next 90 days for all properties
INSERT INTO availability (property_id, date, is_available, special_price) 
WITH date_series AS (
    SELECT CURRENT_DATE + INTERVAL '1 day' * n AS date_value
    FROM generate_series(1, 90) AS n
)
SELECT 
    p.property_id,
    ds.date_value AS date,
    CASE 
        -- Make some random dates unavailable (about 30%)
        WHEN random() < 0.3 THEN false
        ELSE true
    END AS is_available,
    CASE 
        -- Add special pricing for some dates (weekends and holidays)
        WHEN EXTRACT(DOW FROM ds.date_value) IN (0, 6) 
        THEN p.price_per_night * 1.2  -- 20% weekend premium
        WHEN EXTRACT(MONTH FROM ds.date_value) = 12 
        AND EXTRACT(DAY FROM ds.date_value) BETWEEN 20 AND 31
        THEN p.price_per_night * 1.5  -- 50% holiday premium
        ELSE NULL
    END AS special_price
FROM property p
CROSS JOIN date_series ds;

-- Mark booked dates as unavailable
UPDATE availability 
SET is_available = false 
WHERE (property_id, date) IN (
    SELECT b.property_id, generate_series(b.start_date, b.end_date - INTERVAL '1 day', INTERVAL '1 day')::date
    FROM booking b 
    WHERE b.status_id = (SELECT status_id FROM booking_status WHERE status_name = 'confirmed')
);

-- =====================================================
-- CONVERSATIONS DATA
-- =====================================================

INSERT INTO conversation (conversation_id, user1_id, user2_id) VALUES 
('850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010'),
('850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011'),
('850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012'),
('850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440013'),
('850e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010');

-- =====================================================
-- MESSAGES DATA
-- =====================================================

INSERT INTO message (message_id, conversation_id, sender_id, recipient_id, message_body, sent_at, read_at) VALUES 
-- Conversation 1: Guest inquiring about Miami condo
('950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hi Lisa! I''m interested in booking your beachfront condo for March 15-20. Is it available?', '2024-03-05 14:30:00', '2024-03-05 15:45:00'),
('950e8400-e29b-41d4-a716-446655440002', '850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! Yes, those dates are available. The condo has stunning ocean views and direct beach access. Would you like me to send you more photos?', '2024-03-05 16:00:00', '2024-03-05 16:15:00'),
('950e8400-e29b-41d4-a716-446655440003', '850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'That would be great! Also, is parking included?', '2024-03-05 16:20:00', '2024-03-05 17:00:00'),
('950e8400-e29b-41d4-a716-446655440004', '850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Yes, parking is included! I''ll send you the additional photos and booking details now.', '2024-03-05 17:15:00', '2024-03-05 17:30:00'),

-- Conversation 2: Guest asking about Manhattan studio
('950e8400-e29b-41d4-a716-446655440005', '850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Hello David, I''m planning a business trip to NYC. How close is your studio to subway stations?', '2024-04-02 09:15:00', '2024-04-02 10:30:00'),
('950e8400-e29b-41d4-a716-446655440006', '850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Hi Jane! The studio is only 2 blocks from Spring St station (6 line) and 3 blocks from Prince St (N,R,W lines). Perfect for getting anywhere in the city quickly!', '2024-04-02 11:00:00', '2024-04-02 11:15:00'),

-- Conversation 3: Guest inquiring about SF Victorian house
('950e8400-e29b-41d4-a716-446655440007', '850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'Hi Maria! Your Victorian house looks beautiful. We''re a family of 5 - would it be comfortable for us?', '2024-04-25 19:45:00', '2024-04-25 20:15:00'),
('950e8400-e29b-41d4-a716-446655440008', '850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'Hi Mike! Absolutely! The house has 3 bedrooms and can comfortably accommodate 6 guests. There''s also a lovely garden for kids to play. I''d be happy to show you the floor plan.', '2024-04-25 20:30:00', '2024-04-25 21:00:00'),

-- Conversation 4: Post-stay thank you message
('950e8400-e29b-41d4-a716-446655440009', '850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440013', 'Robert, thank you for a wonderful stay in your Hollywood Hills home! The views were incredible and everything was perfect.', '2024-06-06 10:30:00', '2024-06-06 12:15:00'),
('950e8400-e29b-41d4-a716-446655440010', '850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440004', 'Sarah, so glad you enjoyed your stay! It was a pleasure hosting you. You''re welcome back anytime!', '2024-06-06 13:00:00', '2024-06-06 13:30:00'),

-- Conversation 5: Guest asking about Nashville apartment
('950e8400-e29b-41d4-a716-446655440011', '850e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', 'Hi Lisa! I''m a musician visiting Nashville. Is your Music Row apartment close to recording studios?', '2024-06-10 16:20:00', '2024-06-10 17:45:00'),
('950e8400-e29b-41d4-a716-446655440012', '850e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Hi Alex! Perfect location for a musician! You''re within walking distance of several major studios including Historic RCA Studio B. I can provide a list of nearby venues and studios.', '2024-06-10 18:00:00', NULL);

-- =====================================================
-- DATA VERIFICATION QUERIES
-- =====================================================

/*
-- Use these queries to verify the seeded data:

-- Check user distribution by role
SELECT ur.role_name, COUNT(*) as user_count
FROM "user" u 
JOIN user_role ur ON u.role_id = ur.role_id 
GROUP BY ur.role_name;

-- Check properties by city
SELECT a.city, COUNT(*) as property_count, AVG(p.price_per_night) as avg_price
FROM property p 
JOIN address a ON p.address_id = a.address_id 
GROUP BY a.city 
ORDER BY property_count DESC;

-- Check booking status distribution
SELECT bs.status_name, COUNT(*) as booking_count, SUM(b.total_price) as total_revenue
FROM booking b 
JOIN booking_status bs ON b.status_id = bs.status_id 
GROUP BY bs.status_name;

-- Check payment method usage
SELECT pm.method_name, COUNT(*) as payment_count, SUM(p.amount) as total_amount
FROM payment p 
JOIN payment_method pm ON p.method_id = pm.method_id 
GROUP BY pm.method_name;

-- Check review ratings distribution
SELECT rating, COUNT(*) as review_count
FROM review 
GROUP BY rating 
ORDER BY rating;

-- Check most popular property features
SELECT f.feature_name, COUNT(*) as property_count
FROM property_feature pf 
JOIN feature f ON pf.feature_id = f.feature_id 
GROUP BY f.feature_name 
ORDER BY property_count DESC;
*/

-- =====================================================
-- END OF SEEDING SCRIPT
-- =====================================================

-- Script execution summary
SELECT 'Database seeding completed successfully!' as status,
       (SELECT COUNT(*) FROM "user") as total_users,
       (SELECT COUNT(*) FROM property) as total_properties,
       (SELECT COUNT(*) FROM booking) as total_bookings,
       (SELECT COUNT(*) FROM payment) as total_payments,
       (SELECT COUNT(*) FROM review) as total_reviews,
       (SELECT COUNT(*) FROM message) as total_messages;