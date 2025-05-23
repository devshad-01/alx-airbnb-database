# Advanced SQL Queries for Airbnb Clone Database

This directory contains SQL scripts demonstrating advanced database operations for the Airbnb Clone application.

## Task 0: Complex Queries with Joins

The `joins_queries.sql` file demonstrates three types of SQL joins:

### 1. INNER JOIN

Retrieves all bookings and their respective users (guests) who made these bookings. This query shows:
- Booking details (ID, dates, price, status)
- User information (ID, name, email)

The INNER JOIN ensures that only bookings with associated users are returned.

### 2. LEFT JOIN

Retrieves all properties and their reviews, including properties that have not been reviewed. This query shows:
- Property details (ID, name, description, price)
- Review information (ID, rating, comment, date)
- Reviewer information (first name, last name)

The LEFT JOIN ensures that all properties are included in the results, even those without reviews.

### 3. FULL OUTER JOIN

Retrieves all users and all bookings, regardless of whether a user has made a booking or a booking is associated with a user. This query shows:
- User details (ID, name, email, role)
- Booking information (ID, property ID, dates, price, status)

The FULL OUTER JOIN ensures that all users and all bookings are included in the results, showing complete data from both tables.

## Usage

To execute these queries:

```bash
psql -U username -d airbnb_clone -f joins_queries.sql
```

## Task 1: Subqueries

The `subqueries.sql` file demonstrates two types of subqueries:

### 1. Non-correlated Subquery

Finds all properties where the average rating is greater than 4.0. This query:
- Uses a subquery to calculate the average rating for each property
- Returns only properties that meet the rating threshold
- Demonstrates how to use GROUP BY and HAVING within a subquery

### 2. Correlated Subquery

Finds users who have made more than 3 bookings. This query:
- Uses a correlated subquery where the inner query references the outer query
- Counts the number of bookings for each user
- Returns only users who have made more than the specified number of bookings
- Demonstrates how to use correlated subqueries for data filtering based on counts

To execute these subqueries:

```bash
psql -U username -d airbnb_clone -f subqueries.sql
```