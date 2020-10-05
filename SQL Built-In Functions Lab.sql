SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

SELECT REPLACE(`title`, 'The', '***') FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

SELECT SUM(ROUND(`cost`, 2)) AS `Total sum` FROM `books`authors;

SELECT CONCAT_WS(" ", `first_name`, `last_name`) AS `Full Name`,
TIMESTAMPDIFF(DAY, `born`, `died`) AS `Days Lived`
FROM `authors`;

SELECT `title` FROM `books`
WHERE `title` LIKE '%Harry Potter%';