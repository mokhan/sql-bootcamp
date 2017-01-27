# Schema

| BUSINESSES               |              | COMPUTERS   |         | EVENTS      |              |
| ------------------------ | ------------ | ----------- | ------- | ----------- | ------------ |
| id                       | int          | id          | int     | id          | int          |
| name                     | varchar(255) | active      | tinyint | computer_id | int          |
| business_relationship_id | int          | business_id | int     | occurred_at | datetime     |
|                          |              |             |         | type        | varchar(255) |
|                          |              |             |         | data        | text         |

# Lessons

Links:
* https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/

`WHERE` is applied before `GROUP BY`, `HAVING` is applied after and can filter on aggregates.


## Inner join

Produces a set of records that match in both Table A and Table B.

```mysql
SELECT * FROM table_a
INNER JOIN table_b
ON table_a.name = table_b.name;
```

```text
  A |   | B
 ===========
(   | X |   )
 ===========
```


## Full Outer Join

Produces the set of results from both table A and table B, with matching records from both sides where available. 
If there is no match the missing side will contain null.

```mysql
SELECT * FROM table_a
FULL OUTER JOIN table_b
ON table_a.name = table_b.name;
```

```text
  A |   | B
 ===========
( X | X | X )
 ===========
```

## LEFT OUTER JOIN

Produces a complete set of records from table A, with the matching records (where available) in table B.
If there is no match, the right side will contain a null.


To produce a set of results found in table_a but not table_b.

```mysql
SELECT *
FROM table_a
LEFT OUTER JOIN table_b
ON table_a.name table_b.name
where table_b.id IS NULL;
```

```text
  A |   | B
 ===========
( X |   |   )
 ===========
```

To produce a set of results unique to table_a and table_b.

```mysql
SELECT *
FROM table_a
FULL OUTER JOIN table_b
ON table_a.name = table_b.name
WHERE table_a.id IS NULL
OR table_b.id IS NULL;
```

```text
  A |   | B
 ===========
( X |   | X )
 ===========
 ```

# Questions

1. Which businesses have more than N computers?
2. Which computer had the most events in a single day?
3. What are the top 10 most active computers (day, week, month)?  .i.e emits the most events.
4. Which businesses have at least one computer?
5. Which businesses have zero computers?
6. Do we have any computers that belong to a business that doesn't exist?
