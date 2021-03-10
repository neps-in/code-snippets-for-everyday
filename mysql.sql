# Mysql instant usable snippets

# Llist of valid comments in mysql sql file
# Valide comment style 1
-- double dash comment style 2
/*  
	C Style comment that is 
	multi line comment 
*/

-- Create database
create database ecommerce_db;


-- List all database
-- be watchful it is databases (plural) not database 

show databases;


-- Create table with primary key, 
create table people ( 
		person_id INT AUTO_INCREMENT PRIMARY KEY , 
		full_name varchar(50),
		created_on datetime
)
