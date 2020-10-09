DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(19, 4))
BEGIN
SELECT `first_name`, `last_name` FROM employees
WHERE `salary` >= `min_salary`
ORDER BY `first_name`, `last_name`, `employee_id`;
END$$
DELIMITER ;

CALL usp_get_employees_salary_above(45000);

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(start_str VARCHAR(20))
BEGIN
	SELECT `name` FROM towns
    WHERE `name` LIKE concat(start_str, '%')
    ORDER BY `name`;
END$$
DELIMITER ; 

CALL usp_get_towns_starting_with('b');

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name, employee_id;
END$$
DELIMITER ;

CALL usp_get_employees_salary_above_35000();

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	IF (employee_salary < 30000) THEN RETURN 'Low';
    ELSEIF (employee_salary >= 30000 AND employee_salary <= 50000) THEN RETURN 'Average';
    ELSE RETURN 'High';
    END IF;
END$$
DELIMITER ;

SELECT  ufn_get_salary_level(50000);

DROP PROCEDURE IF EXISTS usp_get_employees_by_salary_level;
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(s_level VARCHAR(10))
BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE ufn_get_salary_level(salary) = s_level
    ORDER BY first_name DESC, last_name DESC;
END$$
DELIMITER ;

CALL usp_get_employees_by_salary_level('High');

DROP FUNCTION ufn_calculate_future_value;
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), interest DOUBLE, years INT)
RETURNS DECIMAL(19, 4)
deterministic
BEGIN
	RETURN sum * POW(1 + interest, years);
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.5, 5);


DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(acc_id INT, interest DOUBLE)
BEGIN
	SELECT a.id, ah.first_name, ah.last_name, a.balance, ufn_calculate_future_value(a.balance, interest, 5)
    FROM accounts AS a
    JOIN account_holders AS ah
    ON a.account_holder_id = ah.id
    WHERE a.id = acc_id;
END $$
DELIMITER ;

CALL usp_calculate_future_value_for_account(1, 0.1);


DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF (SELECT COUNT(*) FROM accounts WHERE id = account_id) = 0
    OR (money_amount <= 0)
    THEN ROLLBACK;
    ELSE 
    UPDATE accounts
    SET balance = balance + money_amount
    WHERE id = account_id;
    END IF;
END $$
DELIMITER ; 

DROP PROCEDURE usp_withdraw_money;
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN
	START TRANSACTION;
    IF (SELECT COUNT(*) FROM accounts WHERE id = account_id) = 0
    OR (money_amount <= 0)
    OR ((SELECT balance FROM accounts WHERE account_id = id) <= money_amount)
    THEN ROLLBACK;
    ELSE 
    UPDATE accounts
    SET balance = balance - money_amount
    WHERE id = account_id;
    END IF;
END $$
DELIMITER ; 

CALL usp_withdraw_money(1, 10);

SELECT * FROM accounts;

CREATE TABLE `logs` (
log_id INT PRIMARY KEY AUTO_INCREMENT,
account_id INT,
old_sum DECIMAL (19, 4),
new_sum DECIMAL (19, 4)
);

DELIMITER $$
CREATE TRIGGER tr_on_update
AFTER UPDATE
ON accounts
FOR EACH ROW
BEGIN 
	INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`)
    VALUES
    (OLD.id, OLD.balance, NEW.balance);
END $$
DELIMITER ;

DROP FUNCTION ufn_is_word_comprised;

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
RETURNS INTEGER
DETERMINISTIC
BEGIN
	RETURN (SELECT word REGEXP set_of_letters);
END $$
DELIMITER ;

SELECT ufn_is_word_comprised('bobr', 'Rob');	

DROP PROCEDURE usp_get_employees_from_town;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(45))
BEGIN
	SELECT `first_name`, `last_name` FROM employees AS e
    JOIN addresses AS a ON a.`address_id` = e.`address_id`
    JOIN towns AS t ON t.`town_id` = a.`town_id`
    WHERE town_name = `name`
    ORDER BY `first_name`, `last_name`, `employee_id`;
END$$
DELIMITER ;

CALL usp_get_employees_from_town('Sofia');