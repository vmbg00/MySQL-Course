CREATE TABLE `people`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`name` VARCHAR(200) NOT NULL,
`picture` LONGBLOB,
`height` DOUBLE,
`weight` DOUBLE,
`gender` CHAR NOT NULL,
`birthdate` DATE NOT NULL,
`biography` TEXT
);

INSERT INTO `people`
VALUES 
(1,'Ivan', NULL, 168.15, NULL, 'M', '1990-12-12', NULL),
(2,'Sofiq', NULL, NULL, NULL, 'M', '1991-09-22', NULL),
(3,'Gery', NULL, 150.12, NULL, 'M', '1992-11-15', NULL),
(4,'Joro', NULL, NULL, NULL, 'M', '1993-10-14', NULL),
(5,'Petko', 180.55, NULL, NULL, 'M', '1994-12-13', NULL);


CREATE TABLE `users`(
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(30) NOT NULL,
`profile_picture` LONGBLOB,
`last_login_time` TIMESTAMP,
`is_deleted` BOOL
);

INSERT INTO `users`
VALUES
(1, 'Ivan', '123125', NULL, NOW(), true),
(2, 'Alex', '123124', NULL, NOW(), false),
(3, 'Kristiqn', '123126', NULL, NOW(), false),
(4, 'Petko', '123127', NULL, NOW(), false),
(5, 'Joro', '123128', NULL, NOW(), true);


ALTER TABLE `users`
DROP PRIMARY KEY,
ADD PRIMARY KEY(`id`, `username`);


ALTER TABLE `users` 
CHANGE COLUMN `last_login_time` `last_login_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ;

ALTER TABLE `users` 
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users` UNIQUE (`id`, `username`),
ADD PRIMARY KEY (`pk_users`);


ALTER TABLE `users` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`),
ADD UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE;
;









