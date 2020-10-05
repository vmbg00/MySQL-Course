SELECT `deposit_group`, SUM(`deposit_amount`) AS `DEPOSIT AMOUNT`
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `DEPOSIT AMOUNT` < 150000
ORDER BY `DEPOSIT AMOUNT` DESC;

SELECT COUNT(*) AS `Count` FROM wizzard_deposits;

SELECT `deposit_group`, `magic_wand_creator`, MIN(`deposit_charge`) 
FROM `wizzard_deposits`
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

SELECT 
    (CASE
        WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END) AS `Age Group`,
    COUNT(*) AS 'COUNT'
FROM
    `wizzard_deposits`
GROUP BY `Age Group`
ORDER BY `Age Group`;

SELECT LEFT(`first_name`, 1) AS 'First Letter' FROM wizzard_deposits
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `First Letter`
ORDER BY `First Letter`;

SELECT `deposit_group`, `is_deposit_expired`, AVG(`deposit_interest`) AS 'average_interest'
FROM wizzard_deposits
WHERE `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

SELECT `deposit_group` FROM wizzard_deposits
GROUP BY `deposit_group`;

SELECT 
    `department_id`, MIN(`salary`)
FROM
    employees
WHERE
    `department_id` IN (2, 5, 7)
        AND `hire_date` > '2000-01-01'
GROUP BY `department_id`
ORDER BY `department_id`;


SELECT `department_id` , MAX(`salary`) AS 'MAX SALARY' 
FROM `employees`
GROUP BY `department_id`
HAVING `MAX SALARY`NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

SELECT DISTINCT `salary`FROM `employees`
WHERE `department_id` = 1
ORDER BY `salary` DESC
LIMIT 2, 1;

SELECT E.`department_id`, (SELECT DISTINCT E2.`salary`FROM `employees` AS E2
WHERE E2.`department_id` = E.`department_id`
ORDER BY E2.`salary` DESC
LIMIT 2, 1) AS 'THS'
FROM `employees` AS E
GROUP BY E.`department_id`
HAVING `THS` IS NOT NULL
ORDER BY `department_id`;


SELECT 
    E.`first_name`, E.`last_name`, E.`department_id`
FROM
    `employees` AS E
WHERE
    `salary` > (SELECT 
            AVG(E2.`salary`) AS 'AVG'
        FROM
            `employees` AS E2
        WHERE
            E2.`department_id` = E.`department_id`
        GROUP BY E2.`department_id`)
ORDER BY `department_id` , `employee_id`
LIMIT 10;

SELECT `deposit_group`, ROUND(SUM(`deposit_amount`), 2) AS 'TOTAL SUM'
FROM wizzard_deposits
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

SELECT `deposit_group` FROM wizzard_deposits
GROUP by `deposit_group`
ORDER BY MIN(`magic_wand_size`)
LIMIT 1;

SELECT COUNT(`salary`) AS 'COUNT' FROM `employees`
WHERE `manager_id` IS NULL;

SELECT `department_id`, SUM(`salary`) AS 'total_salary' 
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;
