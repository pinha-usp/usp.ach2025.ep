# Mapeamento de relações

> Gerado pelo ChatGPT

Mostra como mapear relações 1:1, 1:N e M:N para o modelo relacional

- **One-to-one relationship:** In a one-to-one relationship, each record in one table is related to only one record in the
  other table. To represent a one-to-one relationship in PostgreSQL, you can choose either table to contain the foreign
  key column. For example, if you have a one-to-one relationship between "Employee" and "Office", you can add a foreign
  key column "office_id" in the "Employee" table or the "Office" table

- **One-to-many relationship:** In a one-to-many relationship, each record in one table is related to multiple records in
  the other table. To represent a one-to-many relationship in PostgreSQL, add the foreign key column in the "many" table,
  which references the primary key in the "one" table. For example, if you have a one-to-many relationship between
  "Department" and "Employee", where each department has multiple employees, you can add a foreign key column "department_id"
  in the "Employee" table that references the primary key "id" in the "Department" table

- **Many-to-many relationship:** In a many-to-many relationship, multiple records in one table are related to multiple records
  in the other table. To represent a many-to-many relationship in PostgreSQL, create a third table to represent the
  relationship. This third table will contain foreign keys to both tables in the relationship. For example, if you have a
  many-to-many relationship between "Book" and "Author", where each book can have multiple authors and each author can have
  multiple books, you can create a third table "BookAuthor" that contains foreign keys "book_id" and "author_id" that
  reference the primary keys in the "Book" and "Author" tables, respectively
