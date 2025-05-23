-- Task 0: Write Complex Queries with Joins

-- Query 1: INNER JOIN to retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
    u.user_id, u.first_name, u.last_name, u.email
FROM "booking" b
INNER JOIN "user" u ON b.user_id = u.user_id
ORDER BY b.created_at DESC;

-- Query 2: LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews
SELECT 
    p.property_id, p.name, p.description, p.price_per_night,
    r.review_id, r.rating, r.comment, r.created_at as review_date,
    u.first_name as reviewer_first_name, u.last_name as reviewer_last_name
FROM "property" p
LEFT JOIN "review" r ON p.property_id = r.property_id
LEFT JOIN "user" u ON r.user_id = u.user_id
ORDER BY p.name, r.created_at DESC;

-- Query 3: FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT 
    u.user_id, u.first_name, u.last_name, u.email, u.role,
    b.booking_id, b.property_id, b.start_date, b.end_date, b.total_price, b.status
FROM "user" u
FULL OUTER JOIN "booking" b ON u.user_id = b.user_id
ORDER BY u.last_name, u.first_name, b.start_date;