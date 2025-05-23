-- Subquery practice for Airbnb Clone database

-- Non-correlated subquery:
-- Query to find all properties where the average rating is greater than 4.0
SELECT p.*
FROM "property" p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM "review" r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);

-- Correlated subquery:
-- Query to find users who have made more than 3 bookings
SELECT u.*
FROM "user" u
WHERE (
    SELECT COUNT(*)
    FROM "booking" b
    WHERE b.user_id = u.user_id
) > 3;
