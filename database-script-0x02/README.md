# Airbnb Clone Database Seed Data

This directory contains SQL scripts to populate the Airbnb Clone database with sample data for development and testing purposes.

## Overview

The `seed.sql` file contains INSERT statements that add realistic sample data to all tables in the database, reflecting real-world usage patterns and relationships.

## Sample Data Structure

The seed data includes:

### Users (8)
- 3 hosts
- 4 guests
- 1 admin user

### Properties (6)
- Diverse property types (beach condo, mountain cabin, city apartment, etc.)
- Various price points ($179.99 - $499.99 per night)
- Different locations across the United States

### Features (10)
- Common amenities like WiFi, Pool, Kitchen, etc.
- Associated with properties through the property_feature junction table

### Bookings (9)
- Mix of past, current, and future bookings
- Different statuses (confirmed, pending, canceled)
- Realistic date ranges and pricing

### Payments (7)
- One payment for each confirmed booking
- Various payment methods (credit_card, paypal, stripe)

### Reviews (6)
- Ratings from 3-5 stars
- Detailed comments reflecting guest experiences
- Associated with past stays

### Messages (9)
- Conversations between guests and hosts
- Inquiries about property details
- Both read and unread messages

### User Profiles (8)
- Profile data for each user
- Profile pictures (URLs)
- Preferences for language, currency, and notifications

## Data Relationships

The sample data maintains referential integrity across all tables:

1. Each property belongs to a host user
2. Bookings are linked to specific properties and guest users
3. Payments are associated with confirmed bookings
4. Reviews are tied to properties and the users who stayed there
5. Messages track both senders and recipients

## Usage

To populate your database with this sample data:

```bash
psql -U username -d database_name -f seed.sql
```

> **Note**: The script first deletes any existing data to avoid conflicts. Make sure you don't run this on a production database with real data.

## Data Customization

You can customize the sample data by:

1. Modifying the existing INSERT statements
2. Adding more records following the same patterns
3. Adjusting dates to reflect the current calendar year

## UUID Values

The sample data uses predefined UUID values for easy reference and to maintain relationships between tables. In a production environment, these would typically be generated randomly.
