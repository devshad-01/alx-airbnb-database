# Airbnb Database Seeding

This directory contains SQL scripts to populate the Airbnb database with realistic sample data for development and testing purposes.

## Files

- `seed.sql` - Main seeding script that populates all tables with sample data

## Prerequisites

Before running the seeding script, ensure that:

1. The database schema has been created (run the schema creation script first)
2. All required PostgreSQL extensions are installed:
   - `uuid-ossp`
   - `pgcrypto`
   - `postgis`
3. Reference tables (`user_role`, `booking_status`, `payment_method`) are populated

## Sample Data Overview

The seeding script creates realistic sample data including:

### Users (10 total)

- **5 Guests**: Regular users who book properties
- **4 Hosts**: Property owners who list accommodations
- **1 Admin**: System administrator

### Properties (10 total)

Located across major US cities:

- Miami Beach luxury condo
- Manhattan SoHo studio
- San Francisco Victorian house
- Hollywood Hills retreat
- Nashville Music Row apartment
- Chicago lakefront penthouse
- Boston historic brownstone
- Seattle waterfront cottage
- Atlanta midtown loft
- Austin river house

### Bookings (10 total)

- **7 Confirmed** bookings with payments
- **2 Pending** bookings awaiting confirmation
- **1 Canceled** booking

### Additional Data

- **10 Property features** (WiFi, Kitchen, Pool, etc.)
- **8 Payments** for confirmed bookings
- **7 Customer reviews** with ratings 4-5 stars
- **5 Conversations** between guests and hosts
- **12 Messages** showing realistic communication
- **Availability calendar** for next 90 days with special pricing

## How to Run

1. Connect to your PostgreSQL database
2. Execute the schema creation script first (if not already done)
3. Run the seeding script:

```sql
\i seed.sql
```

Or using psql command line:

```bash
psql -d your_database_name -f seed.sql
```

## Data Characteristics

The sample data reflects real-world usage patterns:

### Realistic Pricing

- Properties range from $140-$450 per night
- Weekend and holiday premium pricing (20-50% markup)
- Market-appropriate rates for each city

### Geographic Distribution

- Properties span major US metropolitan areas
- Accurate coordinates and PostGIS geography data
- Addresses reflect actual neighborhood characteristics

### User Behavior Patterns

- Multiple bookings per user showing repeat customers
- Varied booking durations (3-8 nights typical)
- Payment methods distributed across credit card, PayPal, and Stripe
- High customer satisfaction (4-5 star reviews)

### Property Features

- Each property has 3-7 realistic amenities
- Premium properties include luxury features (pool, gym, hot tub)
- Basic amenities (WiFi, kitchen) available on most properties

## Verification Queries

After running the seed script, you can verify the data using these sample queries:

```sql
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
```

## Data Relationships

The seeded data maintains referential integrity with realistic relationships:

- **Users ↔ Properties**: Hosts own multiple properties
- **Bookings ↔ Payments**: All confirmed bookings have corresponding payments
- **Reviews ↔ Bookings**: Reviews reference actual completed stays
- **Messages ↔ Users**: Communication between real guest-host pairs
- **Availability ↔ Bookings**: Booked dates marked as unavailable

## Notes

- All user passwords are hashed using bcrypt
- UUIDs are used consistently for primary keys
- Timestamps reflect realistic booking and communication patterns
- Geographic data includes proper PostGIS geometry for location-based queries
- Sample data is safe for development/testing environments

## Customization

To modify the sample data:

1. Update the INSERT statements in `seed.sql`
2. Maintain referential integrity between tables
3. Keep UUID format consistent
4. Ensure geographic coordinates are valid
5. Test the modified script on a development database first

## Cleanup

To remove all seeded data (use with caution):

```sql
TRUNCATE TABLE message, conversation, availability, review, payment, booking,
               property_feature, property, address, user_profile, "user",
               feature, payment_method, booking_status, user_role CASCADE;
```

This will remove all data while preserving the table structure.
