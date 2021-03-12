# MySQL

## Table Aliases

Aliases are another name given for column name or table name that can be used flexibly or used as short name for table


## Self Join

Use case to find parent relation using a list of person name like

* Find father of individuals.
* Find father, mother of individuals.
* Find manager or supervisors of individuals.

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

## To list Mother's Name with the persons.

```
mysql> select f.name, mo.name as mothername  
		from family f  
		join family mo on f.mother_id = mo.id;
+---------+------------+
| name    | mothername |
+---------+------------+
| Shruthi | Usha       |
| Ganesh  | Lakshmi    |
| Brinda  | Lakshmi    |
+---------+------------+

```

## To list Father's Name and Mother's name with the persons.

```
mysql> select f.name, fa.name as fathername, mo.name as mothername 
			from family f  
			join family fa on f.father_id = fa.id  
			join family mo on f.mother_id = mo.id;

+---------+------------+------------+
| name    | fathername | mothername |
+---------+------------+------------+
| Shruthi | Basavaraj  | Usha       |
| Ganesh  | Nagaraj    | Lakshmi    |
| Brinda  | Nagaraj    | Lakshmi    |
+---------+------------+------------+
```

## Problem 2 
## List out all the persons in the family who does not have not even one child.
Technically speaking list all male, female who dont even have one child.

First we need to find list of person who have atleast one child, and if we filter out all these people we will get list of person who dont have any child.

Lets go step by step, first list find all the father id, for that list all person with their father id.


```
mysql> select f.id , f.name , f.father_id from family f join family fa on fa.id = f.father_id;
+----+---------+-----------+
| id | name    | father_id |
+----+---------+-----------+
|  4 | Shruthi |         9 |
|  5 | Ganesh  |         6 |
|  8 | Brinda  |         6 |
+----+---------+-----------+
```

#### Step 2

Lets now get only father id 

```
mysql> select f.father_id from family f join family fa 
on fa.id = f.father_id;
+-----------+
| father_id |
+-----------+
|         9 |
|         6 |
|         6 |
+-----------+
```

#### Step 3

Now we got the list of father_id who has atleast one child and make this query as a sub query. Use **in operator** ( a set operator ) to list all details from family table that 
matches the subquery list. But actually we dont need this because this gives list of person who has atleast one child. Just add a **NOT** before **in operator** 

Now the complete query is as follows.  

```
mysql> select * from family where id 
not in (select  f.father_id from family f join family fa on fa.id = f.father_id);

+----+----------+-----------+-----------+
| id | name     | father_id | mother_id |
+----+----------+-----------+-----------+
|  1 | Rajmohan |      NULL |      NULL |
|  2 | Kumaran  |      NULL |      NULL |
|  3 | Praveen  |      NULL |      NULL |
|  4 | Shruthi  |         9 |        10 |
|  5 | Ganesh   |         6 |         7 |
|  7 | Lakshmi  |      NULL |      NULL |
|  8 | Brinda   |         6 |         7 |
| 10 | Usha     |      NULL |      NULL |
+----+----------+-----------+-----------+
```

This provides list of persons who is not father of anyone, In our example, Nagaraj have two kids, and Basavaraj have one kid, so both the names are not this list. Which ensures 
our result is correct.

But if you carefully see, Lakshmi, Usha names are in the list. They also have kids. They are mothers of Brinda and Shruti respectively. 

So to get the list of person who dont have any child, we should check mother_id also. Here is the final query below.

```
mysql> select * from family where id  not in (
			select  f.father_id from family f join family fa on fa.id = f.father_id 
			union 
			select  f.mother_id from family f join family fa on fa.id = f.mother_id);


+----+----------+-----------+-----------+
| id | name     | father_id | mother_id |
+----+----------+-----------+-----------+
|  1 | Rajmohan |      NULL |      NULL |
|  2 | Kumaran  |      NULL |      NULL |
|  3 | Praveen  |      NULL |      NULL |
|  4 | Shruthi  |         9 |        10 |
|  5 | Ganesh   |         6 |         7 |
|  8 | Brinda   |         6 |         7 |
+----+----------+-----------+-----------+

```
