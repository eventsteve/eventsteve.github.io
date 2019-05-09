---
title: "Working with UUID in MySQL"
classes: wide
excerpt: "A page with `classes: wide` set to expand the main content's width."
tags: 
  - MySQL
---

When using `layout: single` add the following front matter to a page or post to widen the main content:

```sql
classes: wide
```

UUIDs are not supported directly in MySql, so working with them in SQL can be a bit of a challenge, as they are stored at BINARY(16) and as such are not human readable when doing a simple SELECT * FROM TABLE.

```sql
SELECT *, 
     LOWER(CONCAT(
     SUBSTR(HEX(uuid), 1, 8), '-',
     SUBSTR(HEX(uuid), 9, 4), '-',
     SUBSTR(HEX(uuid), 13, 4), '-',
     SUBSTR(HEX(uuid), 17, 4), '-',
     SUBSTR(HEX(uuid), 21)
 ))
from table_name;
```


```sql
INSERT INTO table_name (uuid_col)
VALUES (UNHEX(REPLACE('22xas33a-32f1-4s2x-83c2-dcsdf6sd7566', '-', '')));

```
## Cupidatat 90's lo-fi authentic try-hard
MySQL UUID vs. Auto-Increment INT as primary key

Pros

Using UUID for a primary key  brings the following advantages:

* UUID values are unique across tables, databases, and even servers that allow you to merge rows from different databases or distribute databases across servers.
* UUID values do not expose the information about your data so they are safer to use in a URL. For example, if a customer with id 10 accesses his account via http://www.example.com/customers/10/ URL, it is easy to guess that there is a customer 11, 12, etc., and this could be a target for an attack.
* UUID values can be generated anywhere that avoid a round trip to the database server. It also simplifies logic in the application. For example, to insert data into a parent table and child tables, you have to insert into the parent table first, get generated id and then insert data into the child tables. By using * * UUID, you can generate the primary key value of the parent table up front and insert rows into both parent and child tables at the same time within a transaction.

Cons

Besides the advantages, UUID values also come with some disadvantages:

* Storing UUID values (16-bytes) takes more storage than integers (4-bytes) or even big integers(8-bytes).
* Debugging seems to be  more difficult, imagine the expression WHERE id = 'df3b7cb7-6a95-11e7-8846-b05adad3f0ae' instead of WHERE id = 10
* Using UUID values may cause performance issues due to their size and not being ordered.

  * Sartorial hoodie
  * Labore viral forage
  * Tote bag selvage
  * DIY exercitation et id ugh tumblr church-key
