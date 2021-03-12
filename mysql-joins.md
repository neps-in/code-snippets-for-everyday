# MySQL

## Table Aliases

Aliases are another name given for column name or table name that can be used flexibly or used as short name for table


## Self Join

Use case to find parent relation using a list of person name like

* Find father of individuals.
* Find manager or supervisors of individuals 


### Table Structure:

we have all the names in the name column, and id is given in father_id, mother_id
appropriately.

```
Family table

+-----------+--------------+------+-----+---------+----------------+
| Field     | Type         | Null | Key | Default | Extra          |
+-----------+--------------+------+-----+---------+----------------+
| id        | int(11)      | NO   | PRI | NULL    | auto_increment |
| name      | varchar(200) | YES  |     | NULL    |                |
| father_id | int(11)      | YES  |     | NULL    |                |
| mother_id | int(11)      | YES  |     | NULL    |                |
+-----------+--------------+------+-----+---------+----------------+

```

Here is the list of all the names with respective father_id, and mother_id 
filled appropriately as per the given usecase

Brinda is daughter of Nagaraj, Lakshmi.

Ganesh is son of Nagaraj, Lakshmi.

Shruthi is daughter of Basavaraj, Usha.

```
mysql> select * from family;
+----+-----------+-----------+-----------+
| id | name      | father_id | mother_id |
+----+-----------+-----------+-----------+
|  1 | Rajmohan  |      NULL |      NULL |
|  2 | Kumaran   |      NULL |      NULL |
|  3 | Praveen   |      NULL |      NULL |
|  4 | Shruthi   |         9 |        10 |
|  5 | Ganesh    |         6 |         7 |
|  6 | Nagaraj   |      NULL |      NULL |
|  7 | Lakshmi   |      NULL |      NULL |
|  8 | Brinda    |         6 |         7 |
|  9 | Basavaraj |      NULL |      NULL |
| 10 | Usha      |      NULL |      NULL |
+----+-----------+-----------+-----------+
```

## To list father names with names of individuals using inner join

```
mysql> select f.name, fa.name as fathername from family f join family fa on f.father_id = fa.id;
+---------+------------+
| name    | fathername |
+---------+------------+
| Shruthi | Basavaraj  |
| Ganesh  | Nagaraj    |
| Brinda  | Nagaraj    |
+---------+------------+
```

## To list father names with names of individuals using left join

Another way to perform the same thing is using left join.

```
mysql> select f.name, fa.name as fathername from family f left join family fa on f.father_id = fa.id;
+-----------+------------+
| name      | fathername |
+-----------+------------+
| Rajmohan  | NULL       |
| Kumaran   | NULL       |
| Praveen   | NULL       |
| Shruthi   | Basavaraj  |
| Ganesh    | Nagaraj    |
| Nagaraj   | NULL       |
| Lakshmi   | NULL       |
| Brinda    | Nagaraj    |
| Basavaraj | NULL       |
| Usha      | NULL       |
+-----------+------------+

```

