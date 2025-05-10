# Database Normalization Process for Airbnb Clone

## Overview

This document outlines the normalization process applied to the Airbnb Clone database schema to ensure it meets Third Normal Form (3NF) requirements. While the original schema was already well-structured, several improvements were made to further normalize the data model.

![Normalized Database Schema](./AirBNB%20Normalised.svg)

## Original Schema Analysis

The initial schema included these main entities:

- User
- Property
- Booking
- Payment
- Review
- Message

Each entity had a unique identifier as the primary key and appropriate foreign key relationships.

## Normalization Steps

### First Normal Form (1NF)

The schema already satisfied 1NF requirements with:

- Atomic values in all attributes
- No repeating groups
- Primary keys for all entities

### Second Normal Form (2NF)

The original schema met 2NF requirements since:

- All tables had single-attribute primary keys (UUIDs)
- No partial dependencies were possible

### Third Normal Form (3NF)

While the schema was close to 3NF, I identified and addressed these transitive dependencies:

1. **Property Location Data**

   - In the original schema, location was a single field
   - This could contain redundant data and would be difficult to query

   **Normalization applied:**

   - Created a separate `Address` entity
   - Linked Property to Address with a foreign key
   - This allows for better geocoding, searching, and prevents duplication of address information

2. **Property Features/Amenities**

   - Properties typically have multiple amenities (WiFi, parking, etc.)
   - These would either be stored in a non-atomic field or duplicated across properties

   **Normalization applied:**

   - Created a `Feature` entity for reusable amenities
   - Created a `PropertyFeature` junction table to establish a many-to-many relationship
   - This prevents duplication and allows for feature filtering

3. **User Authentication and Profile**

   - User authentication data and profile details served different purposes
   - Changes to profile info shouldn't necessitate changes to authentication data

   **Normalization applied:**

   - Split User into core `User` (authentication) and `UserProfile` (personal details)
   - This separates concerns and improves security

## Resulting Schema Benefits

The normalized schema offers several advantages:

1. **Reduced redundancy**

   - Address information isn't duplicated across properties in the same location
   - Features/amenities are defined once and referenced by multiple properties

2. **Improved query flexibility**

   - Location data can be queried at different granularity levels (city, state, country)
   - Features can be easily searched and filtered

3. **Better data integrity**

   - Changes to an address affect all properties at that address
   - Updates to feature names propagate automatically to all associated properties

4. **Enhanced scalability**
   - New features can be added without schema changes
   - Location-based services can leverage the structured address data

## Conclusion

The normalization process transformed an already well-structured schema into a fully 3NF-compliant design. The changes provide a more flexible, maintainable, and scalable foundation for the Airbnb Clone application while eliminating redundancy and preserving data integrity.
