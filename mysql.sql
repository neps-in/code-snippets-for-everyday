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


-- Create database
create database ecommerce_db;


-- List all database
-- be watchful it is databases (plural) not database 

show databases;


-- Create table with primary key, 
```
create table people ( 
		person_id INT AUTO_INCREMENT PRIMARY KEY , 
		full_name varchar(50),
		created_on datetime
)
```

#### To rename column name

```
alter table people change favourite_flaour_id favourite_id int(11) ;

```

In mysql 8.0 you can use rename

```
ALTER TABLE table_name RENAME COLUMN old_col_name TO new_col_name;
```

```
create table ice_cream ( 
		id INT AUTO_INCREMENT PRIMARY KEY , 
		flavour_name varchar(50),
)

create table people ( 
		id INT AUTO_INCREMENT PRIMARY KEY , 
		full_name varchar(50),
		favourite_flavour_id int	
)
```

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

SELECT p.person_id, p.full_name 
	SUM (case when l.end_date < CURRENT_DATE then l.amount else 0 end ) as total 
	FROM people p
	JOIN loan l ON p.person_id = l.person_id and l.is_paid_out = 0
	GROUP BY p.person_id, p.full_name;


