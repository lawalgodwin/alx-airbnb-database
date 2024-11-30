# Partitioning Large Tables

Implementing table partitioning to optimize queries on large datasets.

Mysql does not support partitioning on an existing table.
I had to create a new table and migrate the data from the existing table to the partitioned table. This time without the foreign keys.
A partition table can not be created with foreign key constraint as it complicates things and violates the essence of partitioning.

Hence, you can create a table very similar to the existing as your partition table but without the foreign key constraints of the existing table if it has one.