# Airbnb Clone Database Schema

This directory contains SQL files for defining the Airbnb Clone database schema.

## Overview

The `schema.sql` file implements a fully normalized (3NF) database schema for the Airbnb Clone application. It includes all entities defined in the requirements document, with additional normalization for improved data integrity and reduced redundancy.

## Schema Design Decisions

### Normalization Improvements

1. **Address Normalization**

   - Created a separate `address` table to store property location information
   - This allows for efficient location-based searches and eliminates duplicate address storage

2. **Features/Amenities Normalization**

   - Implemented a many-to-many relationship between properties and features
   - Used a junction table `property_feature` to connect properties with their amenities

3. **User Profile Separation**
   - Split user data into authentication information (`user` table) and profile details (`user_profile` table)
   - Provides better security and separation of concerns

### Constraints and Data Integrity

1. **Date Validation**

   - Booking dates are validated to ensure end_date is after start_date

2. **Ratings Validation**

   - Review ratings are constrained to values between 1 and 5

3. **Cascading Deletes**
   - Appropriate foreign key constraints ensure referential integrity
   - Cascading deletes prevent orphaned records

### Performance Optimizations

1. **Indexing Strategy**

   - Created indexes on frequently queried columns
   - Added compound indexes for common search patterns
   - Location-based indexes for geographic queries

2. **UUID Primary Keys**
   - Used UUIDs for all primary keys to ensure uniqueness and security
   - Enabled the uuid-ossp extension for UUID generation

## Entity Relationship Diagram

The full database schema is visualized in the project's ERD folder.

## Usage

To apply this schema to a PostgreSQL database:

```bash
psql -U username -d database_name -f schema.sql
```

## Extensions

The schema requires the following PostgreSQL extension:

- uuid-ossp: For UUID generation
