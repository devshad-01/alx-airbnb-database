# Airbnb Clone Database

This directory contains SQL scripts and documentation for the Airbnb clone database implementation.

## Directory Structure

- `/database-script-0x01/` - Schema definition scripts
- `/database-script-0x02/` - Database seeding scripts
- `/database-adv-script/` - Advanced SQL scripts with complex queries
- `/ERD/` - Entity Relationship Diagrams and documentation

## Schema Overview

The database schema is designed to support all core functionality of an Airbnb-like platform:

- User management (guests, hosts, admins)
- Property listings with detailed information
- Booking system with different status flows
- Payment processing
- Review and rating system
- Messaging between users
- Availability calendar with special pricing

## Advanced SQL Queries

The `/database-adv-script/` directory contains examples of advanced SQL queries that demonstrate how to work with the Airbnb clone database:

### Joins Queries (`joins_queries.sql`)

This file contains examples of different types of SQL joins:

1. **INNER JOIN**

   - Retrieves all bookings and the respective users who made those bookings
   - Shows complete booking information along with user details

2. **LEFT JOIN**

   - Retrieves all properties and their reviews, including properties that have no reviews
   - Properties without reviews will have NULL values in review columns

3. **FULL OUTER JOIN**

   - Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user
   - Demonstrates comprehensive data retrieval across tables

4. **Bonus: Complex nested join with aggregation**
   - Shows property hosts and their ratings
   - Combines multiple join types with aggregation functions

### Subqueries (`subqueries.sql`)

This file demonstrates the use of SQL subqueries:

1. **Non-Correlated Subquery**

   - Finds properties where the average rating is greater than 4.0
   - Demonstrates independent subqueries that can run on their own

2. **Correlated Subquery**

   - Identifies users who have made more than 3 bookings
   - Shows how subqueries can reference columns from the outer query

3. **Bonus: Nested Subqueries**
   - Finds high-performing properties from hosts with multiple listings
   - Combines multiple subquery techniques for complex analysis

### Aggregations and Window Functions (`aggregations_and_window_functions.sql`)

This file demonstrates the use of SQL aggregation and window functions:

1. **Aggregation with GROUP BY**

   - Counts the total number of bookings made by each user
   - Provides insights into user activity and spending patterns

2. **Window Functions for Ranking**

   - Uses ROW_NUMBER() and RANK() to order properties by booking count
   - Shows different ranking methods and their effects

3. **Partitioned Window Functions**

   - Ranks properties within each city based on popularity
   - Demonstrates how to create context-specific rankings

4. **Advanced Window Function Frames**
   - Calculates running totals and moving averages for revenue
   - Shows how to analyze trends and patterns in time-series data

### Database Optimization (`database_index.sql`, `index_performance.md`, `perfomance.sql`, `optimization_report.md`, `partitioning.sql`, `partition_performance.md`, `performance_monitoring.md`)

These files focus on database performance optimization through indexing, query structure, table partitioning, and continuous monitoring:

1. **Index Creation Scripts**

   - Creates strategic indexes for high-usage columns
   - Includes specialized indexes for spatial data and partial indexes

2. **Performance Analysis**

   - Measures query execution times before and after indexing
   - Demonstrates significant performance improvements for common queries

3. **Query Optimization**

   - Shows progressive optimization of a complex query through multiple versions
   - Demonstrates techniques like CTEs, LATERAL joins, and column reduction

4. **Comprehensive Optimization Report**

   - Documents the entire query optimization process
   - Analyzes performance gains from different optimization strategies
   - Provides best practices and implementation recommendations

5. **Table Partitioning**

   - Implements range partitioning for the Booking table based on date
   - Shows how to migrate data from a regular table to a partitioned structure
   - Demonstrates significant performance improvements for date-range queries

6. **Performance Monitoring**

   - Analyzes execution plans for frequently used queries
   - Identifies bottlenecks and suggests targeted improvements
   - Provides ongoing monitoring recommendations for database health

### Usage

To execute these queries:

1. Ensure your database is set up with the schema from `/database-script-0x01/schema.sql`
2. Populate the database with sample data using `/database-script-0x02/seed.sql`
3. Run the advanced queries using:

```bash
psql -d your_database -f database-adv-script/joins_queries.sql
```

## Database Normalization

The database schema follows normalization principles to reduce redundancy and improve data integrity:

- Tables are organized to minimize data duplication
- Foreign keys ensure referential integrity
- Composite keys are used where appropriate
- Junction tables handle many-to-many relationships

See `normalization.md` for detailed documentation on the normalization process.

## Prerequisites

The database implementation requires:

- PostgreSQL 12+
- PostGIS extension for geographical data
- pgcrypto extension for password hashing
- uuid-ossp extension for UUID generation
