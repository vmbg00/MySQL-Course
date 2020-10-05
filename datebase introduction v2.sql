SELECT `id`, `first_name`, `last_name`, `job_title` FROM `employees`
ORDER BY `id`;

SELECT `id`,  concat(`first_name`, ' ' , `last_name`) AS `Full name`,
`job_title` AS `Job title`, 
`salary` AS `Salary` FROM `employees`
WHERE `salary` > 1000;

SELECT  `last_name`, `salary` FROM `employees`
WHERE `salary` <= 20000;

ALTER TABLE `employees` ADD COLUMN `manager_id` INT;

UPDATE `employees`
SET `manager_id` = 1
WHERE NOT `id` = 1;


SELECT concat(`first_name`, " " ,`last_name`) AS `FULL NAME`, `manager_id`,`job_title`, `salary`
FROM `employees`
WHERE `manager_id` IS NOT NULL
ORDER BY `salary` DESC;

CREATE VIEW `employees_name_salary` AS
SELECT `id`, concat(`first_name`, " " , `last_name`) AS `Full name`, `salary` 
FROM `employees`;

SELECT * FROM `employees_name_salary`
ORDER BY `salary`;

CREATE VIEW `v_top_paid_employee` AS 
SELECT * FROM `employees`
ORDER BY `salary` DESC LIMIT 1;

SELECT * FROM `v_top_paid_employee`;

CREATE TABLE `employees_salary` AS
SELECT `id`, concat_ws(" ",`first_name`,`last_name`) AS "Full name" , `salary`
FROM `employees` 
ORDER BY `salary` DESC;

UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title` = 'Manager';

SELECT `salary` FROM `employees` ORDER BY `salary` DESC;

DELETE FROM `employees`
WHERE `department_id` IN (1, 2);

SELECT * FROM `employees` ORDER BY `id`;

SELECT * FROM `employees` 
WHERE `department_id` = 4 AND `salary` >= 1000
ORDER BY `id`;