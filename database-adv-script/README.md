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

## Task 2: Aggregations and Window Functions

The `aggregations_and_window_functions.sql` file demonstrates the use of SQL aggregation functions and window functions:

### 1. Aggregation with GROUP BY

Finds the total number of bookings made by each user. This query:

- Uses the COUNT function to tally bookings per user
- Employs GROUP BY to organize results by user
- Demonstrates how to create summary statistics from transaction data
- Includes user details for better context in the results

### 2. Window Functions for Ranking

Ranks properties based on the total number of bookings they have received. This query:

- Uses COUNT as an aggregation function to determine booking frequency
- Applies ROW_NUMBER() to assign a unique sequential rank to each property
- Applies RANK() to provide a ranking that handles ties appropriately
- Demonstrates how window functions can provide analytical insights while preserving row details
- Showcases the difference between ROW_NUMBER and RANK window functions

To execute these queries:

```bash
psql -U username -d airbnb_clone -f aggregations_and_window_functions.sql
```

## Task 3: Indexes for Optimization

The `database_index.sql` file contains SQL commands to create indexes that optimize database performance:

### Index Creation

This task involves:

- Identifying high-usage columns in the database that would benefit from indexing
- Creating appropriate indexes using the CREATE INDEX command
- Documenting the performance impact of these indexes

The `index_performance.md` file provides a detailed analysis of:

- Columns selected for indexing and the rationale behind each choice
- Performance measurements before and after index implementation using EXPLAIN
- Quantitative improvements in query execution time
- Recommendations for index usage in a production environment

To execute these index creation commands:

```bash
psql -U username -d airbnb_clone -f database_index.sql
```

## Task 4: Optimize Complex Queries

The `perfomance.sql` file contains a complex query and its optimized version:

### Complex Query Optimization

This task involves:

- Writing a comprehensive query that joins multiple tables (bookings, users, properties, payments)
- Analyzing query performance using EXPLAIN ANALYZE
- Refactoring the query using various optimization techniques

The `optimization_report.md` file provides:

- Detailed analysis of the initial query's performance bottlenecks
- Explanation of optimization techniques applied
- Performance comparison between initial and optimized queries
- Recommendations for further optimization

To execute and analyze the queries:

```bash
psql -U username -d airbnb_clone -f perfomance.sql
```
