USE DemoDB
GO

-- drop the table if it already exists and you have permission to delete
-- be careful with this, there is not an undo feature with this command
DROP TABLE IF EXISTS Student

CREATE TABLE Student
(
student_id      integer       NOT NULL,
first_name      varchar(40)  NOT NULL, 
last_name       varchar(40)  NOT NULL,
dob             date         NOT NULL,
address         varchar(30)  NULL,
contact_number  nvarchar(10) NULL,
department_id   integer       NOT NULL
)