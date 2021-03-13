# Mysql instant usable snippets

# Llist of valid comments in mysql sql file

# Valide comment style 1

-- double dash comment style 2

/*  
	C Style comment that is 
	multi line comment 
*/


/*! MySQL-specific code */
/*! This will not work in other database engine
SELECT 1 /*! +1 */

## System related information

### Find mysql version

There are many ways to find mysql version. 

#### On your command prompt / Terminal / Shell prompt

```
 $ mysql --version
 mysql  Ver 14.14 Distrib 5.7.33, for Linux (x86_64) using  EditLine wrapper
 # Actual version: 5.7.33

 $ mysql -V # its capital V , Small v specify to verbose mode
 mysql  Ver 14.14 Distrib 5.7.33, for Linux (x86_64) using  EditLine wrapper
 # Actual Version 5.7.33
```

inside mysql command prompt / mysql client 

```
mysql> select version();
+-------------------------+
| version()               |
+-------------------------+
| 5.7.33-0ubuntu0.18.04.1 |
+-------------------------+
1 row in set (0.02 sec)
```

# Data Definition Language constructs (DDL)

### Create database
create database ecommerce_db;


### List all database
### be watchful it is **databases** (plural) not database 

```
show databases;
```

### Create table with primary key, 
```
create table people ( 
		person_id INT AUTO_INCREMENT PRIMARY KEY , 
		full_name varchar(50),
		created_on datetime
)
```

### Alter table 

#### add column
alter table people add column favourite_flaour_id int;

--------------------------------------------------------------------

-- Datetime format

`YYYY-MM-DD HH:MM:SS`

-- Example

insert into loan (  
		person_id, 
		amount, 
		end_date, 
		is_paid_out ) 
		value ( 
			'3', 
			'50000', 
			'2021-04-01 00:00:00', 1
		);

insert into ice_cream (flavour_name) value ('Vanila') ;
insert into people( )
SELECT p.person_id, p.full_name 
	SUM (case when l.end_date < CURRENT_DATE then l.amount else 0 end ) as total 
	FROM people p
	JOIN loan l ON p.person_id = l.person_id and l.is_paid_out = 0
	GROUP BY p.person_id, p.full_name;
