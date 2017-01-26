# Schema

| BUSINESSES               |              | COMPUTERS   |         | EVENTS      |              |
| id                       | int          | id          | int     | id          | int          |
| name                     | varchar(255) | active      | tinyint | computer_id | int          |
| business_relationship_id | int          | business_id | int     | occurred_at | datetime     |
|                          |              |             |         | type        | varchar(255) |
|                          |              |             |         | data        | text         |

# Lessons

1. Which businesses have more than N computers?
2. Which computer had the most events in a single day?
3. What are the top 10 most active computers (day, week, month)?  .i.e emits the most events.
4. Which businesses have at least one computer?
5. Which businesses have zero computers?
6. Do we have any computers that belong to a business that doesn't exist?
