CREATE DATABASE nursery;

USE nursery;

CREATE TABLE government_support (
gov_support_id INT NOT NULL UNIQUE PRIMARY KEY,
gov_support_name VARCHAR(200) NOT NULL UNIQUE,
gov_support_amount_a_month DECIMAL(7,2) NOT NULL
);

CREATE TABLE children (
child_id INT NOT NULL UNIQUE,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
gov_support_id INT NOT NULL,
PRIMARY KEY (child_id),
FOREIGN KEY (gov_support_id) REFERENCES government_support (gov_support_id)
);

CREATE TABLE parents (
parent_id INT NOT NULL UNIQUE PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
phone_number CHAR(11) NOT NULL
);

CREATE TABLE relatives (
relatives_id INT NOT NULL UNIQUE PRIMARY KEY,
parent_id INT NOT NULL,
child_id INT NOT NULL,
FOREIGN KEY (parent_id) REFERENCES parents (parent_id),
FOREIGN KEY (child_id) REFERENCES children (child_id)
);

CREATE TABLE employees (
employee_id INT NOT NULL UNIQUE PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
phone_number CHAR(11) NOT NULL,
profession_name VARCHAR(100) NOT NULL
);

CREATE TABLE day_groups (
group_id INT NOT NULL UNIQUE PRIMARY KEY,
group_name VARCHAR(100) NOT NULL,
group_age_start INT NOT NULL,
group_age_end INT NOT NULL,
group_price_an_hour DECIMAL(5, 2) NOT NULL
);

CREATE TABLE meals (
meal_id INT NOT NULL UNIQUE PRIMARY KEY,
meal_name VARCHAR(50) NOT NULL,
group_id INT NOT NULL,
meal_price_a_day DECIMAL(5,2) NOT NULL,
meal_time TIME NOT NULL,
FOREIGN KEY (group_id) REFERENCES day_groups (group_id)
);

CREATE TABLE group_employee (
group_employee_id INT NOT NULL UNIQUE PRIMARY KEY,
group_id INT NOT NULL,
employee_id INT NOT NULL,
FOREIGN KEY (group_id) REFERENCES day_groups (group_id),
FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);

CREATE TABLE visiting_schedule (
visiting_schedule_id INT NOT NULL UNIQUE PRIMARY KEY,
group_id INT NOT NULL,
child_id INT NOT NULL,
start_time TIME NOT NULL,
end_time TIME NOT NULL,
day_of_week VARCHAR(9) NOT NULL,
FOREIGN KEY (group_id) REFERENCES day_groups (group_id),
FOREIGN KEY (child_id) REFERENCES children (child_id)
);

CREATE TABLE attendance (
attendance_id INT NOT NULL UNIQUE PRIMARY KEY,
status VARCHAR(100) NOT NULL
);

CREATE TABLE attendance_log (
attendance_log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
child_id INT NOT NULL,
group_id INT NOT NULL,
date DATE NOT NULL,
start_time TIME,
end_time TIME,
attendance_id INT NOT NULL,
FOREIGN KEY (group_id) REFERENCES day_groups (group_id),
FOREIGN KEY (child_id) REFERENCES children (child_id),
FOREIGN KEY (attendance_id) REFERENCES attendance (attendance_id)
);

INSERT INTO government_support (gov_support_id, gov_support_name, gov_support_amount_a_month)
VALUES
(1, 'none', 0),
(2, 'Childcare Subsidy Program', 100),
(3, 'Early Years Funding Scheme', 150.5);
SELECT * FROM government_support;

INSERT INTO children (child_id, first_name, last_name, date_of_birth, gov_support_id)
VALUES
(1, 'Matthew', 'McConaughey', '2023-11-04', 3),
(2, 'Jane', 'Austen', '2020-12-16', 2),
(3, 'Agatha', 'Christie', '2022-09-15', 1),
(4, 'Jacob', 'Grimm', '2020-01-04', 1),
(5, 'Wilhelm', 'Grimm', '2021-02-24', 1);
SELECT * FROM children;

INSERT INTO parents (parent_id, first_name, last_name, phone_number)
VALUES
(1, 'Mary', 'Kathleen', '07798767253'),
(2, 'James', 'McConaughey', '07934562134'),
(3, 'Clarissa', 'Miller', '07347563254'),
(4, 'Frederick', 'Miller', '09727615678'),
(5, 'George', 'Austen', '09487627345'),
(6, 'Cassandra', 'Lee', '09846327654'),
(7, 'Philip', 'Grimm', '07765245365'),
(8, 'Dorothea', 'Zimmer', '07947619878');
SELECT * FROM parents;

INSERT INTO relatives (relatives_id, parent_id, child_id)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 3),
(4, 4, 3),
(5, 5, 2),
(6, 6, 2),
(7, 7, 4),
(8, 7, 5), 
(9, 8, 4),
(10, 8, 5);
SELECT * FROM relatives;

INSERT INTO employees (employee_id, first_name, last_name, phone_number, profession_name)
VALUES 
(1, 'Emma', 'Johnson', '23456789018', 'Preschool Teacher'),
(2, 'James', 'Williams', '34567890125', 'Nursery Assistant'),
(3, 'Olivia', 'Brown', '45678950123', 'Preschool Teacher'),
(4, 'Alice', 'Smith', '12334567890', 'Nursery Teacher'),
(5, 'Charlie', 'Smith', '56778901234', 'Early Years Educator'),
(6, 'Sophia', 'Miller', '67879012345', 'Child Development Specialist');
SELECT * FROM employees;

INSERT INTO day_groups (group_id, group_name, group_age_start, group_age_end, group_price_an_hour)
VALUES
(1, 'Nursery', 0, 2, 7),
(2, 'Toddler', 1, 3, 6.5),
(3, 'Preschool', 3, 5, 6);
SELECT * FROM day_groups;

INSERT INTO meals (meal_id, meal_name, group_id, meal_price_a_day, meal_time)
VALUES
(1, 'breakfast', 1, 1, '08:00:00'),
(2, 'breakfast', 2, 1, '08:00:00'),
(3, 'breakfast', 3, 2, '08:00:00'),
(4, 'lunch', 1, 2, '12:00:00'),
(5, 'lunch', 2, 2, '12:00:00'),
(6, 'lunch', 3, 3, '12:00:00'),
(7, 'snack', 1, 0.3, '15:00:00'),
(8, 'snack', 2, 0.3, '15:00:00'),
(9, 'snack', 3, 0.4, '15:00:00'),
(10, 'dinner', 1, 1, '17:00:00'),
(11, 'dinner', 2, 2, '17:00:00'),
(12, 'dinner', 3, 2, '17:00:00');
SELECT * FROM meals;

INSERT INTO group_employee (group_employee_id, group_id, employee_id)
VALUES
(1, 1, 4),
(2, 1, 2),
(3, 2, 5),
(4, 2, 6),
(5, 3, 1),
(6, 3, 3);
SELECT * FROM group_employee;

INSERT INTO visiting_schedule (visiting_schedule_id, group_id, child_id, start_time, end_time, day_of_week)
VALUES
(1, 1, 1, '08:00:00', '13:00:00', 'Monday'),
(2, 1, 1, '08:00:00', '13:00:00', 'Wednesday'),
(3, 2, 3, '08:00:00', '18:00:00', 'Thursday'),
(4, 2, 3, '08:00:00', '18:00:00', 'Friday'),
(5, 2, 5, '08:00:00', '13:00:00', 'Wednesday'),
(6, 2, 5, '08:00:00', '13:00:00', 'Thursday'),
(7, 3, 2, '08:00:00', '18:00:00', 'Monday'),
(8, 3, 4, '08:00:00', '13:00:00', 'Wednesday'),
(9, 3, 4, '13:00:00', '18:00:00', 'Friday');
SELECT * FROM visiting_schedule;

INSERT INTO attendance (attendance_id, status)
VALUES
(1, 'present'),
(2, 'sick'),
(3, 'holiday'),
(4, 'bank holiday'),
(5, 'absent');
SELECT * FROM attendance;

INSERT INTO attendance_log (child_id, group_id, date, start_time, end_time, attendance_id)
VALUES
(1, 1, '2024-04-01', NULL, NULL, 4),
(2, 3, '2024-04-01', NULL, NULL, 4),
(1, 1, '2024-04-03', '08:12:00', '13:01:00', 1),
(5, 2, '2024-04-03', '08:24:00', '12:40:00', 1),
(4, 3, '2024-04-03', '08:00:00', '13:05:00', 1),
(3, 2, '2024-04-04', '08:13:00', '17:56:00', 1),
(5, 2, '2024-04-04', '08:00:00', '13:02:00', 1),
(3, 2, '2024-04-05', '08:30:00', '17:45:00', 1),
(4, 3, '2024-04-05', '13:01:00', '18:00:00', 1),
(1, 1, '2024-04-08', '08:00:00', '13:03:00', 1),
(2, 3, '2024-04-08', '08:25:00', '17:47:00', 1),
(1, 1, '2024-04-10', '08:20:00', '13:03:00', 1),
(5, 2, '2024-04-10', NULL, NULL, 3),
(4, 3, '2024-04-10', '08:34:00', '13:01:00', 1),
(3, 2, '2024-04-11', '08:34:00', '18:00:00', 1),
(5, 2, '2024-04-11', NULL, NULL, 3),
(3, 2, '2024-04-12', '08:23:00', '17:46:00', 1),
(4, 3, '2024-04-12', '13:01:00', '18:00:00', 1),
(1, 1, '2024-04-15', '08:23:00', '13:02:00', 1),
(2, 3, '2024-04-15', NULL, NULL, 2),
(1, 1, '2024-04-17', '08:12:00', '13:03:00', 1),
(5, 2, '2024-04-17', '08:12:00', '13:00:00', 1),
(4, 3, '2024-04-17', '08:34:00', '12:55:00', 1),
(3, 2, '2024-04-18', NULL, NULL, 2),
(5, 2, '2024-04-18', '08:21:00', '13:00:00', 1),
(3, 2, '2024-04-19', NULL, NULL, 2),
(4, 3, '2024-04-19', '13:20:00', '18:00:00', 1),
(1, 1, '2024-04-22', '08:35:00', '12:57:00', 1),
(2, 3, '2024-04-22', '08:03:00', '18:00:00', 1),
(1, 1, '2024-04-24', '08:50:00', '13:10:00', 1),
(5, 2, '2024-04-24', NULL, NULL, 3),
(4, 3, '2024-04-24', '08:01:00', '13:00:00', 1),
(3, 2, '2024-04-25', '08:07:00', '18:01:00', 1),
(5, 2, '2024-04-25', NULL, NULL, 3),
(3, 2, '2024-04-26', '08:15:00', '18:10:00', 1),
(4, 3, '2024-04-26', '13:16:00', '18:01:00', 1),
(1, 1, '2024-04-29', '08:03:00', '13:10:00', 1),
(2, 3, '2024-04-29', '08:04:00', '18:02:00', 1),
(1, 1, '2024-05-01', '08:10:00', '13:00:00', 1),
(5, 2, '2024-05-01', '08:05:00', '13:08:00', 1),
(4, 3, '2024-05-01', NULL, NULL, 2),
(3, 2, '2024-05-02', '08:00:00', '18:03:00', 1),
(5, 2, '2024-05-02', '08:07:00', '13:10:00', 1),
(3, 2, '2024-05-03', '08:30:00', '18:05:00', 1),
(4, 3, '2024-05-03', NULL, NULL, 2),
(1, 1, '2024-05-06', NULL, NULL, 4),
(2, 3, '2024-05-06', NULL, NULL, 4),
(1, 1, '2024-05-08', '08:08:00', '12:34:00', 1),
(5, 2, '2024-05-08', '08:13:00', '13:00:00', 1),
(4, 3, '2024-05-08', '08:02:00', '13:01:00', 1),
(3, 2, '2024-05-09', '08:10:00', '17:54:00', 1),
(5, 2, '2024-05-09', '08:02:00', '13:01:00', 1),
(3, 2, '2024-05-10', '08:02:00', '18:01:00', 1),
(4, 3, '2024-05-10', '13:04:00', '18:03:00', 1),
(1, 1, '2024-05-13', NULL, NULL, 2),
(2, 3, '2024-05-13', '08:02:00', '18:06:00', 1),
(1, 1, '2024-05-15', NULL, NULL, 2),
(5, 2, '2024-05-15', '08:03:00', '13:1:00', 1),
(4, 3, '2024-05-15', '08:15:00', '13:10:00', 1),
(3, 2, '2024-05-16', '08:23:00', '17:57:00', 1),
(5, 2, '2024-05-16', '08:01:00', '13:00:00', 1),
(3, 2, '2024-05-17', NULL, NULL, 3),
(4, 3, '2024-05-17', '13:00:00', '18:00:00', 1),
(1, 1, '2024-05-20', '08:05:00', '13:05:00', 1),
(2, 3, '2024-05-20', '08:00:00', '18:01:00', 1);
SELECT * FROM attendance_log;

# examples of the tables: attendance log (slide 4)
SELECT * FROM children;
SELECT * FROM meals;
SELECT * FROM visiting_schedule;
SELECT * FROM employees;
SELECT * FROM day_groups;

# query: attendance log (slide 5)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS child_full_name, 
al.date AS date, a.status AS attendance_status
FROM children c INNER JOIN attendance_log al ON c.child_id = al.child_id 
INNER JOIN attendance a ON al.attendance_id = a.attendance_id
ORDER BY date;

# stored function: whether parents picked up their child in scheduled time or not
# slide 6
DELIMITER //

CREATE FUNCTION late_pick_up (
sched_end_time TIME,
attend_end_time TIME)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN

DECLARE pick_up VARCHAR(50);
IF attend_end_time <= sched_end_time
THEN SET pick_up = 'in time';
ELSEIF attend_end_time > sched_end_time
THEN SET pick_up = 'late';
END IF;

RETURN pick_up;
END //

DELIMITER ;

# application of the stored function (slide 7)
WITH timing_table AS
(SELECT c.first_name, al.date, v.end_time
AS schedule_end, al.end_time AS attendance_end,
late_pick_up(v.end_time, al.end_time)
AS pick_up_timing
FROM children c JOIN
attendance_log al USING (child_id)
JOIN visiting_schedule v 
ON al.child_id = v.child_id
WHERE v.day_of_week = DATE_FORMAT(al.date, '%W')
HAVING pick_up_timing IS NOT NULL
ORDER BY date, c.first_name)

SELECT *, ROUND(COUNT(CASE WHEN pick_up_timing = 'late'
THEN 1 ELSE NULL END)
OVER (PARTITION BY first_name) * 100 / 
COUNT(*) OVER (PARTITION BY first_name), 0)
AS percent_of_late_pick_ups FROM timing_table;

# stored procedure: calculate total cost for the next month's attendance
# slide 8
DELIMITER //

CREATE PROCEDURE total_cost_a_month (start_date DATE, end_date DATE)
BEGIN

DROP TABLE IF EXISTS dates;
DROP TABLE IF EXISTS cost_separation;
DROP TABLE IF EXISTS total_cost_a_month;

CREATE TABLE dates (date DATE, week_day VARCHAR(9));

WHILE start_date <= end_date DO
INSERT INTO dates VALUES (start_date, date_format(start_date, '%W'));
SET start_date = DATE_ADD(start_date, INTERVAL 1 DAY);
END WHILE;

CREATE TABLE cost_separation (child_id INT, group_cost_a_month DECIMAL (10,2), meal_cost_a_month DECIMAL (10,2));

INSERT INTO cost_separation (child_id, group_cost_a_month, meal_cost_a_month)
(SELECT child_id, SUM(number_of_weekday * total_hours_a_day * group_price_an_hour) AS group_cost_a_month, 
SUM(number_of_weekday * meal_cost_a_day) AS meal_cost_a_month
FROM
(SELECT d.week_day, COUNT(d.week_day) AS number_of_weekday, 
v.child_id, v.group_id, dg.group_price_an_hour, timestampdiff(HOUR, v.start_time, v.end_time) AS total_hours_a_day, v.day_of_week,
mc.meal_cost_a_day
FROM dates d JOIN visiting_schedule v ON v.day_of_week = d.week_day
JOIN day_groups dg ON dg.group_id = v.group_id
JOIN 
(SELECT v.child_id, v.day_of_week, SUM(m.meal_price_a_day) AS meal_cost_a_day
FROM visiting_schedule v JOIN meals m USING(group_id)
WHERE m.meal_time BETWEEN v.start_time AND v.end_time
GROUP BY child_id, day_of_week
ORDER BY child_id) AS mc ON mc.child_id = v.child_id AND mc.day_of_week = v.day_of_week
GROUP BY week_day, day_of_week, child_id, total_hours_a_day, mc.meal_cost_a_day, v.group_id) AS temp_1
GROUP BY child_id, group_id
ORDER BY child_id);

CREATE TABLE total_cost_a_month (child_id INT, total_cost DECIMAL(10,2));

INSERT INTO total_cost_a_month (child_id, total_cost)
SELECT cs.child_id, (cs.group_cost_a_month + cs.meal_cost_a_month - g.gov_support_amount_a_month) AS total_cost
FROM cost_separation cs JOIN children USING(child_id) JOIN government_support g USING(gov_support_id)
ORDER BY cs.child_id;

SELECT * FROM total_cost_a_month;

END//

DELIMITER ;

# CALL total_cost_a_month ('2024-06-01', '2024-06-30');

# reccuring event: create a list with the cost of attendance for next month's payment
# slide 9
SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT rec_event__next_month_payment
ON SCHEDULE EVERY 1 MONTH
STARTS '2024-05-20 10:43:00' # change to a convenient date and time
DO BEGIN

CALL total_cost_a_month(
DATE_ADD(LAST_DAY(CURRENT_DATE), INTERVAL 1 DAY),
LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH))
);

CREATE VIEW view_total_cost_a_month AS
SELECT DISTINCT t.total_cost, CONCAT(c.first_name, ' ', c.last_name) AS child_full_name
FROM children c JOIN total_cost_a_month t USING(child_id)
ORDER BY child_full_name;

END//

DELIMITER ;

# view: attendance schedule for children
# slide 10
CREATE VIEW view_attendance_schedule AS

SELECT CONCAT(c.first_name, ' ', c.last_name) AS child_full_name, dg.group_name,
v.day_of_week, v.start_time, v.end_time
FROM children c INNER JOIN visiting_schedule v ON c.child_id = v.child_id
INNER JOIN day_groups dg ON dg.group_id = v.group_id
ORDER BY group_name, child_full_name;

SELECT * FROM view_attendance_schedule;

# query: who attends the Toddler group on Thursday
SELECT child_full_name, group_name, day_of_week
FROM view_attendance_schedule
WHERE group_name = 'Toddler' AND day_of_week = 'Thursday';

# query: who attends the Preschool group on Monday
SELECT child_full_name, group_name, day_of_week
FROM view_attendance_schedule
WHERE group_name = 'Preschool' AND day_of_week = 'Monday';

# trigger: check the group for a child before inserting data into the "visiting_schedule" table.
# slide 11
DELIMITER //

CREATE TRIGGER trigger_child_group
BEFORE INSERT ON visiting_schedule
FOR EACH ROW
BEGIN
DECLARE child_age INT;
SELECT DISTINCT TIMESTAMPDIFF(YEAR, date_of_birth, CURRENT_DATE()) INTO child_age
FROM children
WHERE children.child_id = NEW.child_id;

IF child_age < 
(SELECT DISTINCT group_age_start 
FROM day_groups WHERE day_groups.group_id = NEW.group_id)
THEN signal sqlstate '45000' set message_text = 'This child should attend a younger group.';
ELSEIF child_age >
(SELECT DISTINCT group_age_end 
FROM day_groups WHERE day_groups.group_id = NEW.group_id)
THEN signal sqlstate '45000' set message_text = 'This child should attend an older group.';
END IF;

END//

DELIMITER ;

# application of the trigger (slide 12)
INSERT INTO visiting_schedule (visiting_schedule_id, group_id, child_id, start_time, end_time, day_of_week)
VALUES
(10, 2, 1, '08:00:00', '13:00:00', 'Monday');

INSERT INTO visiting_schedule (visiting_schedule_id, group_id, child_id, start_time, end_time, day_of_week)
VALUES
(10, 2, 4, '08:00:00', '13:00:00', 'Monday');

INSERT INTO visiting_schedule (visiting_schedule_id, group_id, child_id, start_time, end_time, day_of_week)
VALUES
(10, 3, 4, '08:00:00', '13:00:00', 'Monday');

# DELETE FROM visiting_schedule WHERE visiting_schedule_id = 10;

# Thank you!
