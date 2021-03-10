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
		full_name varchar(50),
		created_on datetime
)
```