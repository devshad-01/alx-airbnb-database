# Advanced SQL Queries for Airbnb Clone Database

This directory contains advanced SQL scripts demonstrating complex query techniques for the Airbnb clone database.

## Files

- `joins_queries.sql`: Examples of different types of joins (INNER, LEFT, FULL OUTER)
- `subqueries.sql`: Examples of correlated and non-correlated subqueries
- `aggregations_and_window_functions.sql`: Examples of aggregation and window functions
- `database_index.sql`: SQL commands to create indexes for query optimization
- `index_performance.md`: Analysis of query performance improvements with indexes
- `perfomance.sql`: Complex query optimization examples with multiple versions
- `optimization_report.md`: Comprehensive analysis of query optimization techniques
- `partitioning.sql`: Implementation of table partitioning for large tables
- `partition_performance.md`: Analysis of performance improvements with partitioned tables
- `performance_monitoring.md`: Query performance analysis, bottleneck identification, and optimization recommendations

## Joins Queries Explanation

The `joins_queries.sql` file contains examples of different SQL join types applied to the Airbnb clone database:

### 1. INNER JOIN

```sql
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    -- other fields...
FROM
    booking b
INNER JOIN
    "user" u ON b.user_id = u.user_id
-- other joins...
```

- **Purpose**: Retrieve all bookings and the users who made them
- **Tables Involved**: booking, user, user_profile, property, booking_status
- **Results**: Only shows bookings that have an associated user
- **Use Case**: When you need to display booking information with user details for confirmed reservations

### 2. LEFT JOIN

```sql
SELECT
    p.property_id,
    p.name AS property_name,
    -- other fields...
FROM
    property p
LEFT JOIN
    review r ON p.property_id = r.property_id
-- other joins...
```

- **Purpose**: Retrieve all properties and their reviews, including properties with no reviews
- **Tables Involved**: property, review, user, user_profile, address
- **Results**: Shows all properties, with NULL values in review columns for properties without reviews
- **Use Case**: When displaying a property listing page that should show all properties regardless of whether they have reviews

### 3. FULL OUTER JOIN

```sql
SELECT
    u.user_id,
    up.first_name,
    -- other fields...
FROM
    "user" u
FULL OUTER JOIN
    booking b ON u.user_id = b.user_id
-- other joins...
```

- **Purpose**: Retrieve all users and all bookings, even if a user has no bookings or a booking has no user
- **Tables Involved**: user, booking, user_profile, user_role, booking_status, property
- **Results**: Shows all users and all bookings with NULL values where no match exists
- **Use Case**: For comprehensive system audits or generating reports that need to account for all users and all bookings

### 4. Bonus: Complex Nested Join with Aggregation

```sql
SELECT
    host.user_id AS host_id,
    host_profile.first_name || ' ' || host_profile.last_name AS host_name,
    -- other fields and aggregations...
FROM
    "user" host
INNER JOIN
    user_profile host_profile ON host.user_id = host_profile.user_id
-- other joins...
GROUP BY
    -- grouped fields...
```

- **Purpose**: Generate a comprehensive host performance report
- **Tables Involved**: user, user_profile, user_role, property, address, review, booking, booking_status
- **Results**: Shows hosts with their properties, average ratings, booking counts, and revenue
- **Use Case**: For administrative dashboards or host performance analytics

## How to Use These Queries

1. Ensure your database is populated with the schema and sample data
2. Execute individual queries to understand the different join types
3. Modify the queries to fit your specific needs
4. Study the query structure to learn how to build complex, multi-table queries

## Performance Considerations

- The FULL OUTER JOIN query may be resource-intensive on large datasets
- Consider adding appropriate indexes to improve performance
- For production use, you may need to add WHERE clauses to limit the result set size

## Subqueries Explanation

The `subqueries.sql` file demonstrates the use of both correlated and non-correlated subqueries in the context of the Airbnb clone database.

### 1. Non-Correlated Subquery - Properties with High Ratings

```sql
SELECT
    p.property_id,
    p.name AS property_name,
    -- other fields...
FROM
    property p
INNER JOIN
    address a ON p.address_id = a.address_id
INNER JOIN (
    SELECT
        property_id,
        AVG(rating) AS average_rating
    FROM
        review
    GROUP BY
        property_id
    HAVING
        AVG(rating) > 4.0
) AS AVG_RATING ON p.property_id = AVG_RATING.property_id
```

- **Purpose**: Find properties with an average rating greater than 4.0
- **Type**: Non-correlated subquery (independent of the outer query)
- **Results**: Only returns properties with high ratings (> 4.0)
- **Use Case**: When displaying "top-rated" properties to users as featured listings

### 2. Correlated Subquery - Users with Multiple Bookings

```sql
SELECT
    u.user_id,
    up.first_name,
    -- other fields...
FROM
    "user" u
INNER JOIN
    user_profile up ON u.user_id = up.user_id
WHERE
    (
        SELECT
            COUNT(booking_id)
        FROM
            booking b
        WHERE
            b.user_id = u.user_id
    ) > 3
```

- **Purpose**: Find users who have made more than 3 bookings
- **Type**: Correlated subquery (references the outer query)
- **Results**: Returns users with a booking count greater than 3
- **Use Case**: For identifying frequent customers for loyalty programs or targeted marketing

### 3. Bonus: Nested Subqueries for Complex Analysis

```sql
SELECT
    p.property_id,
    p.name AS property_name,
    -- other fields...
FROM
    property p
-- other joins...
WHERE
    (
        SELECT AVG(rating)
        FROM review r
        WHERE r.property_id = p.property_id
    ) > (
        SELECT AVG(rating) FROM review
    )
    AND
    (
        SELECT COUNT(*)
        FROM property
        WHERE host_id = p.host_id
    ) > 1
```

- **Purpose**: Find properties with above-average ratings owned by hosts with multiple properties
- **Type**: Multiple nested subqueries (both correlated and non-correlated)
- **Results**: Returns high-performing properties from experienced hosts
- **Use Case**: For identifying "superhost" properties or premium listings

## Subquery vs. JOIN Performance

- **Subqueries** can sometimes be less efficient than equivalent JOINs, especially for large datasets
- **Correlated subqueries** execute once for each row in the outer query, potentially causing performance issues
- Consider using **indexes** on columns used in subquery conditions
- For complex queries, **execution plans** can help determine the most efficient approach
- Some subqueries can be **rewritten as JOINs** for better performance in certain database systems

## Aggregations and Window Functions Explanation

The `aggregations_and_window_functions.sql` file demonstrates the use of SQL aggregation functions and window functions for analyzing data in the Airbnb clone database.

### 1. Aggregation with GROUP BY - Bookings per User

```sql
SELECT
    u.user_id,
    up.first_name,
    up.last_name,
    COUNT(b.booking_id) AS booking_count,
    SUM(b.total_price) AS total_spent
FROM
    "user" u
LEFT JOIN
    booking b ON u.user_id = b.user_id
LEFT JOIN
    user_profile up ON u.user_id = up.user_id
GROUP BY
    u.user_id, up.first_name, up.last_name
ORDER BY
    booking_count DESC;
```

- **Purpose**: Count the total number of bookings made by each user
- **Functions Used**: COUNT(), SUM(), GROUP BY
- **Results**: Shows users with their booking counts and total spending
- **Use Case**: User activity analysis, identifying frequent customers

### 2. Window Functions - Property Rankings

```sql
SELECT
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS booking_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank_unique,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM
    property p
LEFT JOIN
    booking b ON p.property_id = b.property_id
GROUP BY
    p.property_id, p.name
ORDER BY
    booking_count DESC;
```

- **Purpose**: Rank properties based on the total number of bookings they have received
- **Functions Used**: ROW_NUMBER(), RANK(), COUNT()
- **Results**: Properties with their booking counts and different types of rankings
- **Use Case**: Identifying most popular properties, featuring top listings

### 3. Window Functions with Partitioning - City-specific Rankings

```sql
SELECT
    p.name AS property_name,
    a.city,
    COUNT(b.booking_id) AS booking_count,
    RANK() OVER (PARTITION BY a.city ORDER BY COUNT(b.booking_id) DESC) AS city_booking_rank
FROM
    property p
LEFT JOIN
    booking b ON p.property_id = b.property_id
INNER JOIN
    address a ON p.address_id = a.address_id
GROUP BY
    p.property_id, p.name, a.city
ORDER BY
    a.city, booking_count DESC;
```

- **Purpose**: Rank properties within each city based on booking counts
- **Functions Used**: RANK() with PARTITION BY, COUNT()
- **Results**: Properties ranked within their respective cities
- **Use Case**: Location-specific popularity analysis, city-based recommendations

### 4. Bonus: Advanced Window Functions with Frames

```sql
SELECT
    b.start_date,
    SUM(b.total_price) AS daily_revenue,
    SUM(SUM(b.total_price)) OVER (ORDER BY b.start_date) AS cumulative_revenue,
    AVG(SUM(b.total_price)) OVER (
        ORDER BY b.start_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS seven_day_avg_revenue
FROM
    booking b
GROUP BY
    b.start_date
ORDER BY
    b.start_date;
```

- **Purpose**: Calculate running totals and moving averages for booking revenue
- **Functions Used**: SUM(), AVG() with window frames
- **Results**: Daily revenue with cumulative totals and 7-day moving averages
- **Use Case**: Revenue trend analysis, seasonality detection

## Differences Between Aggregation and Window Functions

- **Aggregation Functions** (with GROUP BY):

  - Collapse multiple rows into a single result row
  - Return one row per group
  - Examples: COUNT(), SUM(), AVG(), MIN(), MAX()

- **Window Functions**:
  - Perform calculations across rows related to the current row
  - Preserve all rows in the result set
  - Allow access to multiple rows without collapsing them
  - Examples: ROW_NUMBER(), RANK(), DENSE_RANK(), LEAD(), LAG()

## Performance Considerations

- **Aggregation Performance**:

  - Add indexes on GROUP BY columns for better performance
  - Consider materialized views for frequently used aggregations

- **Window Function Performance**:
  - Window functions may be computationally expensive
  - Large PARTITION BY clauses can consume significant memory
  - Consider pre-aggregating data for large datasets

## Database Indexing and Optimization

The `database_index.sql` and `index_performance.md` files demonstrate strategies for optimizing database performance through strategic indexing.

### Index Creation Strategy

Indexes have been created for high-usage columns that frequently appear in:

- WHERE clauses (filtering conditions)
- JOIN conditions
- ORDER BY clauses
- GROUP BY operations

```sql
-- Example indexes from database_index.sql
CREATE INDEX idx_booking_dates ON booking (start_date, end_date);
CREATE INDEX idx_property_price ON property (price_per_night);
CREATE INDEX idx_user_email ON "user" (email);
```

### Types of Indexes Used

1. **Single-Column Indexes**

   - Created on frequently filtered columns like `email`, `role_id`, and `price_per_night`
   - Improves performance of simple equality and range queries

2. **Composite Indexes**

   - Created on columns that are frequently used together
   - Example: `(start_date, end_date)` for booking date range queries

3. **Spatial Indexes**

   - GiST index on the `geog` column for efficient spatial queries
   - Crucial for location-based property searches

4. **Partial Indexes**
   - Created on filtered subsets of data
   - Example: Index only on available properties to optimize availability searches

### Performance Impact Analysis

The `index_performance.md` file contains:

1. **Before/After Comparisons**

   - Query execution plans and times before adding indexes
   - The same queries analyzed after index creation
   - Performance improvement metrics

2. **Analysis of Query Plans**

   - How the PostgreSQL query planner uses the indexes
   - Which indexes provide the most significant performance gains
   - Explanation of how index access methods work

3. **Optimization Recommendations**
   - Which indexes to prioritize for maintenance
   - Trade-offs between query performance and write performance
   - Index size and maintenance considerations

### Index Performance Summary

| Query Type        | Before Indexing | After Indexing | Improvement |
| ----------------- | --------------- | -------------- | ----------- |
| Date Range Search | 7.022ms         | 1.743ms        | 75.2%       |
| User Bookings     | 3.502ms         | 0.941ms        | 73.1%       |
| Property Ratings  | 5.631ms         | 1.145ms        | 79.7%       |

### Best Practices for Index Usage

- Don't create indexes on columns that are rarely used in queries
- Consider the write overhead of maintaining indexes
- Use EXPLAIN ANALYZE to verify index usage
- Create indexes to support foreign keys
- Consider partial indexes for frequently filtered subsets
- Maintain indexes through periodic REINDEX operations
