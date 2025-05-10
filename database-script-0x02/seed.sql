-- Airbnb Clone Database Sample Data
-- This script populates the database with realistic sample data for testing and development

-- Clear existing data (if any) to avoid conflicts
-- Running the delete operations in reverse order of the table dependencies
DELETE FROM "property_feature";
DELETE FROM "feature";
DELETE FROM "user_profile";
DELETE FROM "message";
DELETE FROM "review";
DELETE FROM "payment";
DELETE FROM "booking";
DELETE FROM "property";
DELETE FROM "address";
DELETE FROM "user";

-- Seed User data
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    -- Hosts
    ('11111111-1111-1111-1111-111111111111', 'John', 'Smith', 'john@example.com', '$2a$10$xVVoGjS7MTs5hUM.fNftge9WmU0NLLtlJ5nGr5gLcOLHDG9qsBJ6.', '+12125551234', 'host', '2024-01-15 08:00:00'),
    ('22222222-2222-2222-2222-222222222222', 'Maria', 'Garcia', 'maria@example.com', '$2a$10$y3pD4HG9MGM2ZJuarKbQP.jNdEgZBX1x7bIPpSS5g2RZM1L5sLKcC', '+12125552345', 'host', '2024-01-20 09:15:00'),
    ('33333333-3333-3333-3333-333333333333', 'Ahmed', 'Hassan', 'ahmed@example.com', '$2a$10$QPUXq7ffrxlQkFHtJe37sOJ9s9YZLHKDp8YrGOGK3mHgPWMJrNODC', '+12125553456', 'host', '2024-02-01 10:30:00'),
    
    -- Guests
    ('44444444-4444-4444-4444-444444444444', 'Emily', 'Johnson', 'emily@example.com', '$2a$10$qaS9xvCea8S/Xat.7Xl5UeXWX0gySzSGVJxJTF9Bx/1UKvG6HQO/i', '+12125554567', 'guest', '2024-02-10 11:45:00'),
    ('55555555-5555-5555-5555-555555555555', 'Michael', 'Brown', 'michael@example.com', '$2a$10$8PMVt1R950jaG8Ys9WAXEuS1RvXw6bEGLFFj6dEQMjTXG5S7D4POe', '+12125555678', 'guest', '2024-02-15 13:00:00'),
    ('66666666-6666-6666-6666-666666666666', 'Sophia', 'Lee', 'sophia@example.com', '$2a$10$fI4G2yfUNLGR8fVEZQXFjOScU/4mQq7wBhJ2XWGR0LI5zTfKPUlJO', '+12125556789', 'guest', '2024-02-20 14:15:00'),
    ('77777777-7777-7777-7777-777777777777', 'David', 'Wilson', 'david@example.com', '$2a$10$FUn5WE3lXR3iXMO5tnoBKeD4S3bjCCllYqF04F4XU0JZU32Rck0YC', '+12125557890', 'guest', '2024-02-25 15:30:00'),
    
    -- Admin
    ('88888888-8888-8888-8888-888888888888', 'Admin', 'User', 'admin@example.com', '$2a$10$KN5AnTULNgLuVMgqBZxlHOQxhUcGDQNHwTgqR0TOt0fUmAOxKJZJO', '+12125558901', 'admin', '2024-01-01 00:00:00');

-- Seed Address data
INSERT INTO "address" (address_id, street_address, city, state, country, postal_code, latitude, longitude)
VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '123 Beach Road', 'Miami', 'Florida', 'USA', '33139', 25.7617, -80.1918),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '456 Mountain View', 'Aspen', 'Colorado', 'USA', '81611', 39.1911, -106.8175),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', '789 Downtown Apt', 'New York', 'New York', 'USA', '10001', 40.7128, -74.0060),
    ('dddddddd-dddd-dddd-dddd-dddddddddddd', '101 Lakeview Drive', 'Chicago', 'Illinois', 'USA', '60601', 41.8781, -87.6298),
    ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', '202 Sunset Blvd', 'Los Angeles', 'California', 'USA', '90001', 34.0522, -118.2437),
    ('ffffffff-ffff-ffff-ffff-ffffffffffff', '303 City Center', 'San Francisco', 'California', 'USA', '94016', 37.7749, -122.4194),
    ('gggggggg-gggg-gggg-gggg-gggggggggggg', '404 Riverside Drive', 'Austin', 'Texas', 'USA', '78701', 30.2672, -97.7431),
    ('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', '505 Grand Avenue', 'Seattle', 'Washington', 'USA', '98101', 47.6062, -122.3321);

-- Seed Property data
INSERT INTO "property" (property_id, host_id, address_id, name, description, price_per_night, created_at, updated_at)
VALUES
    ('pppppppp-1111-pppp-1111-pppppppppppp', '11111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 
     'Beachfront Paradise', 'Stunning ocean views from this luxury beachfront condo with pool access and private balcony.', 
     199.99, '2024-02-01 08:00:00', '2024-02-01 08:00:00'),
     
    ('pppppppp-2222-pppp-2222-pppppppppppp', '11111111-1111-1111-1111-111111111111', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 
     'Mountain Retreat', 'Cozy cabin in the mountains with stunning views, wood fireplace, and hot tub.', 
     249.99, '2024-02-05 09:15:00', '2024-02-05 09:15:00'),
     
    ('pppppppp-3333-pppp-3333-pppppppppppp', '22222222-2222-2222-2222-222222222222', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 
     'Downtown Apartment', 'Modern city apartment in the heart of downtown with amazing skyline views.', 
     179.99, '2024-02-10 10:30:00', '2024-02-10 10:30:00'),
     
    ('pppppppp-4444-pppp-4444-pppppppppppp', '22222222-2222-2222-2222-222222222222', 'dddddddd-dddd-dddd-dddd-dddddddddddd', 
     'Lakeside Villa', 'Beautiful villa with lake access, private dock, and panoramic views.', 
     299.99, '2024-02-15 11:45:00', '2024-02-15 11:45:00'),
     
    ('pppppppp-5555-pppp-5555-pppppppppppp', '33333333-3333-3333-3333-333333333333', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 
     'Hollywood Hills Home', 'Luxurious home with infinity pool and views of the entire city.', 
     499.99, '2024-02-20 13:00:00', '2024-02-20 13:00:00'),
     
    ('pppppppp-6666-pppp-6666-pppppppppppp', '33333333-3333-3333-3333-333333333333', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 
     'Downtown Loft', 'Artistic loft in a converted warehouse with high ceilings and city views.', 
     229.99, '2024-02-25 14:15:00', '2024-02-25 14:15:00');

-- Seed Feature data
INSERT INTO "feature" (feature_id, name, description)
VALUES
    ('fe111111-fe11-fe11-fe11-fe1111111111', 'WiFi', 'High-speed wireless internet'),
    ('fe222222-fe22-fe22-fe22-fe2222222222', 'Pool', 'Swimming pool access'),
    ('fe333333-fe33-fe33-fe33-fe3333333333', 'Hot Tub', 'Private hot tub/jacuzzi'),
    ('fe444444-fe44-fe44-fe44-fe4444444444', 'Kitchen', 'Full kitchen with appliances'),
    ('fe555555-fe55-fe55-fe55-fe5555555555', 'Free Parking', 'On-premises parking'),
    ('fe666666-fe66-fe66-fe66-fe6666666666', 'Air Conditioning', 'Central AC system'),
    ('fe777777-fe77-fe77-fe77-fe7777777777', 'Washer/Dryer', 'In-unit laundry facilities'),
    ('fe888888-fe88-fe88-fe88-fe8888888888', 'TV', 'Smart TV with streaming services'),
    ('fe999999-fe99-fe99-fe99-fe9999999999', 'Gym', 'Access to fitness center'),
    ('fe000000-fe00-fe00-fe00-fe0000000000', 'Pets Allowed', 'Pet-friendly accommodation');

-- Seed PropertyFeature junction table
INSERT INTO "property_feature" (property_id, feature_id)
VALUES
    -- Beachfront Paradise features
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe222222-fe22-fe22-fe22-fe2222222222'),
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe555555-fe55-fe55-fe55-fe5555555555'),
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-1111-pppp-1111-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    
    -- Mountain Retreat features
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe333333-fe33-fe33-fe33-fe3333333333'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe555555-fe55-fe55-fe55-fe5555555555'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe777777-fe77-fe77-fe77-fe7777777777'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    ('pppppppp-2222-pppp-2222-pppppppppppp', 'fe000000-fe00-fe00-fe00-fe0000000000'),
    
    -- Downtown Apartment features
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe777777-fe77-fe77-fe77-fe7777777777'),
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    ('pppppppp-3333-pppp-3333-pppppppppppp', 'fe999999-fe99-fe99-fe99-fe9999999999'),
    
    -- Lakeside Villa features
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe222222-fe22-fe22-fe22-fe2222222222'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe333333-fe33-fe33-fe33-fe3333333333'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe555555-fe55-fe55-fe55-fe5555555555'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe777777-fe77-fe77-fe77-fe7777777777'),
    ('pppppppp-4444-pppp-4444-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    
    -- Hollywood Hills Home features
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe222222-fe22-fe22-fe22-fe2222222222'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe555555-fe55-fe55-fe55-fe5555555555'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe777777-fe77-fe77-fe77-fe7777777777'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    ('pppppppp-5555-pppp-5555-pppppppppppp', 'fe999999-fe99-fe99-fe99-fe9999999999'),
    
    -- Downtown Loft features
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe111111-fe11-fe11-fe11-fe1111111111'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe444444-fe44-fe44-fe44-fe4444444444'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe555555-fe55-fe55-fe55-fe5555555555'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe666666-fe66-fe66-fe66-fe6666666666'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe777777-fe77-fe77-fe77-fe7777777777'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe888888-fe88-fe88-fe88-fe8888888888'),
    ('pppppppp-6666-pppp-6666-pppppppppppp', 'fe000000-fe00-fe00-fe00-fe0000000000');

-- Seed Booking data (including past, current, and future bookings)
INSERT INTO "booking" (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    -- Completed bookings (past)
    ('b1111111-b111-b111-b111-b111111111b1', 'pppppppp-1111-pppp-1111-pppppppppppp', '44444444-4444-4444-4444-444444444444', 
     '2024-03-01', '2024-03-05', 799.96, 'confirmed', '2024-02-15 09:30:00'),
     
    ('b2222222-b222-b222-b222-b222222222b2', 'pppppppp-2222-pppp-2222-pppppppppppp', '55555555-5555-5555-5555-555555555555', 
     '2024-03-10', '2024-03-15', 1249.95, 'confirmed', '2024-02-20 11:15:00'),
     
    ('b3333333-b333-b333-b333-b333333333b3', 'pppppppp-3333-pppp-3333-pppppppppppp', '66666666-6666-6666-6666-666666666666', 
     '2024-03-15', '2024-03-20', 899.95, 'confirmed', '2024-02-28 13:45:00'),
    
    -- Current bookings
    ('b4444444-b444-b444-b444-b444444444b4', 'pppppppp-4444-pppp-4444-pppppppppppp', '44444444-4444-4444-4444-444444444444', 
     '2025-05-05', '2025-05-10', 1499.95, 'confirmed', '2025-04-15 10:00:00'),
     
    ('b5555555-b555-b555-b555-b555555555b5', 'pppppppp-5555-pppp-5555-pppppppppppp', '55555555-5555-5555-5555-555555555555', 
     '2025-05-07', '2025-05-12', 2499.95, 'confirmed', '2025-04-20 14:30:00'),
    
    -- Future bookings
    ('b6666666-b666-b666-b666-b666666666b6', 'pppppppp-6666-pppp-6666-pppppppppppp', '66666666-6666-6666-6666-666666666666', 
     '2025-06-01', '2025-06-07', 1609.93, 'confirmed', '2025-05-01 08:45:00'),
     
    ('b7777777-b777-b777-b777-b777777777b7', 'pppppppp-1111-pppp-1111-pppppppppppp', '77777777-7777-7777-7777-777777777777', 
     '2025-06-15', '2025-06-20', 999.95, 'confirmed', '2025-05-05 09:30:00'),
     
    -- Pending booking
    ('b8888888-b888-b888-b888-b888888888b8', 'pppppppp-2222-pppp-2222-pppppppppppp', '44444444-4444-4444-4444-444444444444', 
     '2025-07-01', '2025-07-05', 999.96, 'pending', '2025-05-06 11:15:00'),
     
    -- Canceled booking
    ('b9999999-b999-b999-b999-b999999999b9', 'pppppppp-3333-pppp-3333-pppppppppppp', '55555555-5555-5555-5555-555555555555', 
     '2025-07-10', '2025-07-15', 899.95, 'canceled', '2025-05-07 13:00:00');

-- Seed Payment data for confirmed bookings
INSERT INTO "payment" (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('pay11111-pay1-pay1-pay1-pay11111111', 'b1111111-b111-b111-b111-b111111111b1', 799.96, '2024-02-15 09:35:00', 'credit_card'),
    ('pay22222-pay2-pay2-pay2-pay22222222', 'b2222222-b222-b222-b222-b222222222b2', 1249.95, '2024-02-20 11:20:00', 'paypal'),
    ('pay33333-pay3-pay3-pay3-pay33333333', 'b3333333-b333-b333-b333-b333333333b3', 899.95, '2024-02-28 13:50:00', 'credit_card'),
    ('pay44444-pay4-pay4-pay4-pay44444444', 'b4444444-b444-b444-b444-b444444444b4', 1499.95, '2025-04-15 10:05:00', 'stripe'),
    ('pay55555-pay5-pay5-pay5-pay55555555', 'b5555555-b555-b555-b555-b555555555b5', 2499.95, '2025-04-20 14:35:00', 'credit_card'),
    ('pay66666-pay6-pay6-pay6-pay66666666', 'b6666666-b666-b666-b666-b666666666b6', 1609.93, '2025-05-01 08:50:00', 'paypal'),
    ('pay77777-pay7-pay7-pay7-pay77777777', 'b7777777-b777-b777-b777-b777777777b7', 999.95, '2025-05-05 09:35:00', 'stripe');

-- Seed Review data for past stays
INSERT INTO "review" (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('rev11111-rev1-rev1-rev1-rev11111111', 'pppppppp-1111-pppp-1111-pppppppppppp', '44444444-4444-4444-4444-444444444444', 
     5, 'Amazing beachfront property with incredible views! The host was very accommodating and responsive. Will definitely stay here again!', 
     '2024-03-06 14:00:00'),
     
    ('rev22222-rev2-rev2-rev2-rev22222222', 'pppppppp-2222-pppp-2222-pppppppppppp', '55555555-5555-5555-5555-555555555555', 
     4, 'Beautiful mountain retreat, very peaceful and relaxing. The hot tub was perfect after a day of hiking. Only issue was the slow WiFi.',
     '2024-03-16 10:30:00'),
     
    ('rev33333-rev3-rev3-rev3-rev33333333', 'pppppppp-3333-pppp-3333-pppppppppppp', '66666666-6666-6666-6666-666666666666', 
     5, 'Perfect location in the heart of downtown. Walking distance to restaurants, shops, and attractions. The apartment was clean and modern.',
     '2024-03-21 18:45:00'),
     
    ('rev44444-rev4-rev4-rev4-rev44444444', 'pppppppp-1111-pppp-1111-pppppppppppp', '55555555-5555-5555-5555-555555555555', 
     4, 'Great ocean views and comfortable accommodations. The pool was a bit crowded but still enjoyable.',
     '2024-04-10 11:15:00'),
     
    ('rev55555-rev5-rev5-rev5-rev55555555', 'pppppppp-2222-pppp-2222-pppppppppppp', '66666666-6666-6666-6666-666666666666', 
     5, 'Stunning cabin with all the amenities you could want. The fireplace and hot tub made for the perfect winter getaway.',
     '2024-04-15 15:30:00'),
     
    ('rev66666-rev6-rev6-rev6-rev66666666', 'pppppppp-3333-pppp-3333-pppppppppppp', '77777777-7777-7777-7777-777777777777', 
     3, 'Good location but the apartment was smaller than it appeared in the photos. Clean and functional though.',
     '2024-04-22 09:00:00');

-- Seed Message data
INSERT INTO "message" (message_id, sender_id, recipient_id, message_body, sent_at, read_at)
VALUES
    -- Conversation between guest and host about Beachfront Paradise
    ('msg11111-msg1-msg1-msg1-msg11111111', '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 
     'Hi, I am interested in booking your beachfront condo. Is it available for the first week of March?', 
     '2024-02-10 09:00:00', '2024-02-10 09:15:00'),
     
    ('msg22222-msg2-msg2-msg2-msg22222222', '11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 
     'Hello! Yes, the condo is available for those dates. Would you like me to send you more information?', 
     '2024-02-10 09:15:00', '2024-02-10 09:20:00'),
     
    ('msg33333-msg3-msg3-msg3-msg33333333', '44444444-4444-4444-4444-444444444444', '11111111-1111-1111-1111-111111111111', 
     'That would be great. Also, is the pool heated?', 
     '2024-02-10 09:25:00', '2024-02-10 09:30:00'),
     
    ('msg44444-msg4-msg4-msg4-msg44444444', '11111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 
     'Yes, the pool is heated year-round. I will send you the details shortly.', 
     '2024-02-10 09:35:00', '2024-02-10 09:40:00'),
     
    -- Conversation between guest and host about Mountain Retreat
    ('msg55555-msg5-msg5-msg5-msg55555555', '55555555-5555-5555-5555-555555555555', '11111111-1111-1111-1111-111111111111', 
     'Is the cabin accessible by regular car or do we need a 4x4 for the mountain roads?', 
     '2024-02-15 13:00:00', '2024-02-15 13:10:00'),
     
    ('msg66666-msg6-msg6-msg6-msg66666666', '11111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 
     'The main road is paved and maintained, so a regular car is fine unless there is heavy snowfall. In winter, chains might be necessary.', 
     '2024-02-15 13:15:00', '2024-02-15 13:20:00'),
     
    -- Message about Downtown Loft
    ('msg77777-msg7-msg7-msg7-msg77777777', '66666666-6666-6666-6666-666666666666', '33333333-3333-3333-3333-333333333333', 
     'Hi, I see that your loft allows pets. Is there an additional fee, and are there size restrictions?', 
     '2024-04-25 10:00:00', '2024-04-25 10:15:00'),
     
    ('msg88888-msg8-msg8-msg8-msg88888888', '33333333-3333-3333-3333-333333333333', '66666666-6666-6666-6666-666666666666', 
     'Hello! Yes, there is a $50 pet fee. We welcome most pets under 50lbs, but please let me know what type of pet you have.', 
     '2024-04-25 10:30:00', '2024-04-25 10:45:00'),
     
    -- Unread message
    ('msg99999-msg9-msg9-msg9-msg99999999', '77777777-7777-7777-7777-777777777777', '22222222-2222-2222-2222-222222222222', 
     'I just booked your lakeside villa and wanted to ask if early check-in is possible?', 
     '2025-05-08 11:00:00', NULL);

-- Seed UserProfile data
INSERT INTO "user_profile" (profile_id, user_id, profile_picture, bio, preferred_language, preferred_currency, notification_preferences, updated_at)
VALUES
    ('prof1111-prf1-prf1-prf1-prof1111111', '11111111-1111-1111-1111-111111111111', 
     'https://example.com/profilepics/john.jpg', 
     'Travel enthusiast and property investor with multiple luxury homes in prime locations.', 
     'English', 'USD', 
     '{"email": true, "sms": true, "push": false}', 
     '2024-01-15 08:00:00'),
     
    ('prof2222-prf2-prf2-prf2-prof2222222', '22222222-2222-2222-2222-222222222222', 
     'https://example.com/profilepics/maria.jpg', 
     'I love sharing my beautiful properties with travelers from around the world. Superhost for 3 years running!', 
     'Spanish', 'USD', 
     '{"email": true, "sms": true, "push": true}', 
     '2024-01-20 09:15:00'),
     
    ('prof3333-prf3-prf3-prf3-prof3333333', '33333333-3333-3333-3333-333333333333', 
     'https://example.com/profilepics/ahmed.jpg', 
     'Architect and interior designer offering unique spaces with thoughtful design elements.', 
     'English', 'USD', 
     '{"email": true, "sms": false, "push": true}', 
     '2024-02-01 10:30:00'),
     
    ('prof4444-prf4-prf4-prf4-prof4444444', '44444444-4444-4444-4444-444444444444', 
     'https://example.com/profilepics/emily.jpg', 
     'Adventure seeker looking for unique stays during my travels. I love beach destinations!', 
     'English', 'USD', 
     '{"email": true, "sms": false, "push": false}', 
     '2024-02-10 11:45:00'),
     
    ('prof5555-prf5-prf5-prf5-prof5555555', '55555555-5555-5555-5555-555555555555', 
     'https://example.com/profilepics/michael.jpg', 
     'Business traveler who appreciates comfort and convenience. Clean, well-appointed spaces are my priority.', 
     'English', 'EUR', 
     '{"email": true, "sms": true, "push": false}', 
     '2024-02-15 13:00:00'),
     
    ('prof6666-prf6-prf6-prf6-prof6666666', '66666666-6666-6666-6666-666666666666', 
     'https://example.com/profilepics/sophia.jpg', 
     'Digital nomad working remotely and exploring new cities. Fast WiFi is essential!', 
     'Korean', 'USD', 
     '{"email": true, "sms": false, "push": true}', 
     '2024-02-20 14:15:00'),
     
    ('prof7777-prf7-prf7-prf7-prof7777777', '77777777-7777-7777-7777-777777777777', 
     'https://example.com/profilepics/david.jpg', 
     'Family traveler seeking kid-friendly accommodations with all the comforts of home.', 
     'English', 'GBP', 
     '{"email": true, "sms": true, "push": false}', 
     '2024-02-25 15:30:00'),
     
    ('prof8888-prf8-prf8-prf8-prof8888888', '88888888-8888-8888-8888-888888888888', 
     'https://example.com/profilepics/admin.jpg', 
     'Platform administrator ensuring quality standards and user satisfaction.', 
     'English', 'USD', 
     '{"email": true, "sms": true, "push": true}', 
     '2024-01-01 00:00:00');
