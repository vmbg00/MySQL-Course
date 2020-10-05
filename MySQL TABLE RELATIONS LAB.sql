CREATE TABLE `mountains`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL);

CREATE TABLE `peaks`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`mountain_id` INT,
CONSTRAINT fk_mountains_id 
FOREIGN KEY(`mountain_id`)
REFERENCES `mountains`(`id`)
ON UPDATE CASCADE
ON DELETE SET NULL
);

SELECT v.`driver_id`, v.`vehicle_type`, CONCAT(c.`first_name`, ' ',c.`last_name`) AS 'Driver name'  FROM `vehicles` AS v JOIN `campers` AS c
ON v.`driver_id` = c.`id`;

SELECT `starting_point`, `end_point`, `leader_id`, CONCAT(c.`first_name`, ' ',c.`last_name`) AS 'Leader name'
FROM `routes` AS r JOIN `campers` AS c
ON 
r.`leader_id` = c.`id`;

ALTER TABLE `peaks`
DROP FOREIGN KEY `fk_peaks_mountains`;

ALTER TABLE `peaks`
ADD CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY(`mountain_id`)
REFERENCES `mountains`(`id`)
ON UPDATE CASCADE
ON DELETE CASCADE;
