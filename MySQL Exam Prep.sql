CREATE DATABASE instd;
USE instd;

CREATE TABLE `users` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL UNIQUE,
`password` VARCHAR(30) NOT NULL,
`email` VARCHAR(50) NOT NULL,
`gender` CHAR(1) NOT NULL,
`age` INT NOT NULL,
`job_title` VARCHAR(40) NOT NULL,
`ip` VARCHAR(30) NOT NULL
);

CREATE TABLE `addresses`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`address` VARCHAR(30) NOT NULL,
`town` VARCHAR(30) NOT NULL,
`country` VARCHAR(30) NOT NULL,
`user_id` INT NOT NULL,
CONSTRAINT fk_addresses_users
FOREIGN KEY (`user_id`)
REFERENCES `users`(`id`)
);

CREATE TABLE `photos`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`description` TEXT NOT NULL,
`date` DATETIME NOT NULL,
`views` INT NOT NULL DEFAULT 0
);

CREATE TABLE `users_photos`(
`user_id` INT NOT NULL,
`photo_id` INT NOT NULL,

CONSTRAINT fk_users_photos_users
FOREIGN KEY (`user_id`)
REFERENCES `users`(`id`),

CONSTRAINT fk_users_photos_photos
FOREIGN KEY (`photo_id`)
REFERENCES `photos`(`id`)
);

CREATE TABLE `likes` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`photo_id` INT,
`user_id` INT,

CONSTRAINT fk_likes_users
FOREIGN KEY (`user_id`)
REFERENCES `users`(`id`),

CONSTRAINT fk_likes_photos
FOREIGN KEY (`photo_id`)
REFERENCES `photos`(`id`)
);

CREATE TABLE `comments`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`comment` VARCHAR(255) NOT NULL,
`date` DATETIME NOT NULL,
`photo_id` INT NOT NULL,

CONSTRAINT fk_comments_photos
FOREIGN KEY(`photo_id`)
REFERENCES `photos`(`id`)
);

INSERT INTO `addresses` (`address`, `town`, `country`, `user_id`)
SELECT `username`, `password`, `ip`, `age` FROM `users`
WHERE `gender` = 'M';

UPDATE `addresses`
SET `country` = 
(
	CASE 
		WHEN LEFT(`country`, 1) = 'B' THEN 'Blocked'
		WHEN LEFT(`country`, 1) = 'T' THEN 'Test'
		WHEN LEFT(`country`, 1) = 'P' THEN 'In Progress'
    END 
)
WHERE LEFT(`country`, 1) IN ('B', 'P', 'T');

DELETE FROM `addresses`
WHERE `id` % 3 = 0;

SELECT `username`, `gender`, `age` FROM `users`
ORDER BY `age` DESC, `username`;

SELECT p.`id`, p.`date`, p.`description`, COUNT(c.`id`) AS 'commentCount'
FROM photos AS p
JOIN `comments` AS c
ON p.`id` = c.`photo_id`
GROUP BY p.`id`
ORDER BY `commentCount` DESC, p.`id`
LIMIT 5;

SELECT CONCAT_WS(' ', u.`id`, u.`username`) AS `id_username`, u.`email` 
FROM `users` AS u
JOIN `users_photos` AS up
ON u.`id` = up.`user_id`
JOIN `photos` AS p
ON up.`photo_id` = p.`id`
WHERE u.`id` = p.`id`
ORDER BY u.`id`;

SELECT p.`id` AS 'photo_id', COUNT(DISTINCT l.`id`) AS 'likes_count', COUNT(DISTINCT c.`id`) AS 'comment_count' 
FROM `photos` AS p
LEFT JOIN `likes` AS l
ON p.`id` = l.`photo_id`
LEFT JOIN `comments` AS c
ON p.`id` = c.`photo_id`
GROUP BY p.`id`
ORDER BY likes_count DESC, comment_count DESC, p.`id`;

SELECT CONCAT(LEFT(p.`description`,30), '...') AS 'summary', p.`date`
FROM `photos` AS p
WHERE DAY(p.`date`) = 10
ORDER BY p.`date` DESC;

DROP FUNCTION udf_users_photos_count;

DELIMITER $$
CREATE FUNCTION udf_users_photos_count(p_username VARCHAR(30))
RETURNS INT
DETERMINISTIC 
BEGIN
	return (SELECT COUNT(up.`user_id`)
			FROM `users_photos` AS up
			LEFT JOIN `users` AS u
			ON u.`id` = up.`user_id`
            WHERE u.`username` = p_username
            );
END$$
DELIMITER ;

SELECT udf_users_photos_count('ssantryd') AS 'photosCount';


DELIMITER $$
CREATE PROCEDURE udp_modify_user (p_address VARCHAR(30), v_town VARCHAR(30)) 
BEGIN
	UPDATE `users` AS u
    JOIN `addresses` AS a
    ON u.`id` = a.`user_id`
    SET `age` = `age` + 10
    WHERE a.`address` = p_address AND a.`town` = v_town;
END $$
DELIMITER ;

CALL udp_modify_user('97 Valley Edge Parkway', 'Divinópolis');

CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
