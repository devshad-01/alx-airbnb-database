# Entity-Relationship Requirements for Airbnb Clone

![Airbnb ER Diagram](./Airbnb%20ER%20Diagram.svg)

## Entities and Attributes

### User

- **user_id**: Primary Key, UUID, Indexed
- **first_name**: VARCHAR, NOT NULL
- **last_name**: VARCHAR, NOT NULL
- **email**: VARCHAR, UNIQUE, NOT NULL
- **password_hash**: VARCHAR, NOT NULL
- **phone_number**: VARCHAR, NULL
- **role**: ENUM (guest, host, admin), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Property

- **property_id**: Primary Key, UUID, Indexed
- **host_id**: Foreign Key, references User(user_id)
- **name**: VARCHAR, NOT NULL
- **description**: TEXT, NOT NULL
- **location**: VARCHAR, NOT NULL
- **pricepernight**: DECIMAL, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **updated_at**: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### Booking

- **booking_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key, references Property(property_id)
- **user_id**: Foreign Key, references User(user_id)
- **start_date**: DATE, NOT NULL
- **end_date**: DATE, NOT NULL
- **total_price**: DECIMAL, NOT NULL
- **status**: ENUM (pending, confirmed, canceled), NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Payment

- **payment_id**: Primary Key, UUID, Indexed
- **booking_id**: Foreign Key, references Booking(booking_id)
- **amount**: DECIMAL, NOT NULL
- **payment_date**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- **payment_method**: ENUM (credit_card, paypal, stripe), NOT NULL

### Review

- **review_id**: Primary Key, UUID, Indexed
- **property_id**: Foreign Key, references Property(property_id)
- **user_id**: Foreign Key, references User(user_id)
- **rating**: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
- **comment**: TEXT, NOT NULL
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

### Message

- **message_id**: Primary Key, UUID, Indexed
- **sender_id**: Foreign Key, references User(user_id)
- **recipient_id**: Foreign Key, references User(user_id)
- **message_body**: TEXT, NOT NULL
- **sent_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

## Relationships

1. **User to Property (one-to-many)**:

   - A user (as host) can list multiple properties
   - Each property belongs to exactly one host

2. **User to Booking (one-to-many)**:

   - A user can make multiple bookings
   - Each booking is associated with exactly one user

3. **Property to Booking (one-to-many)**:

   - A property can have multiple bookings
   - Each booking is for exactly one property

4. **Booking to Payment (one-to-one)**:

   - Each booking can have exactly one payment
   - Each payment is associated with exactly one booking

5. **User to Review (one-to-many)**:

   - A user can write multiple reviews
   - Each review is written by exactly one user

6. **Property to Review (one-to-many)**:

   - A property can receive multiple reviews
   - Each review is for exactly one property

7. **User to Message (one-to-many, bidirectional)**:
   - A user can send multiple messages
   - A user can receive multiple messages
   - Each message has exactly one sender and one recipient

## Constraints

- Users must have a unique email address
- Property listings must have a host, name, description, location, and price
- Bookings must have valid start and end dates with end_date > start_date
- Reviews must have a rating between 1 and 5
- Payment amounts must match the booking's total price

## Indexes

- Primary keys are indexed by default
- Foreign keys are indexed for efficient joins
- User email is indexed for fast lookup during authentication
- Property location is indexed to optimize geographic searches
