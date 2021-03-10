# Mysql instant usable snippets

## Create database

```
create database ecommerce_db;
```

## List all database

be watchful it is databases (plural) not database 

```
show databases;
```

## Create table with primary key, 




```
create table people ( 
		person_id INT AUTO_INCREMENT PRIMARY KEY , 
		full_name varchar(50)
)
```

```
create table loan (
	loan_id int AUTO_INCREMENT PRIMARY KEY,
	person_id int,
	amount int,
	end_date datetime,
	is_paid_out int )
```

