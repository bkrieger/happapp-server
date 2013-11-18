DROP TABLE users;
CREATE TABLE users (
id int NOT NULL AUTO_INCREMENT,
phone_number CHARACTER(10) NOT NULL UNIQUE,
os CHARACTER(1) NOT NULL,
pn_token VARCHAR(255),
PRIMARY KEY (id)
);

-- All times are in UTC
DROP TABLE happs_by_day;
CREATE TABLE happs_by_day (
id int NOT NULL AUTO_INCREMENT,
day DATE NOT NULL UNIQUE,
counter int DEFAULT 0,
PRIMARY KEY (id)
);

-- All times are in UTC
-- To convert from period to time, do: period*.25. This gives you the number of hours after midnight.
-- For example, period 10 -> 10*.25 = 2.5 -> 2:30am - 2:45am. period 80 -> 80*.25 = 20 -> 8pm - 8:15pm 
DROP TABLE happs_within_day;
CREATE TABLE happs_within_day (
period int NOT NULL AUTO_INCREMENT,
counter int DEFAULT 0,
PRIMARY KEY (period)
);


-- TEST
-- INSERT INTO users (phone_number, os) VALUES ("6969696969", 1);