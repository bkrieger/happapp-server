DROP TABLE users;
CREATE TABLE users (
id int NOT NULL AUTO_INCREMENT,
phone_number CHARACTER(10) NOT NULL,
os BINARY,
pn_enabled BOOLEAN DEFAULT FALSE, 
PRIMARY KEY (id)
);

-- TEST
-- INSERT INTO users (phone_number, os) VALUES ("6969696969", 1);