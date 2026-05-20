USE interstellar;


CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL,
    planet VARCHAR(20) NOT NULL
);

DELIMITER //

DROP PROCEDURE IF EXISTS searchUser;

CREATE PROCEDURE searchUser(IN name VARCHAR(255))
BEGIN
    SET @sql = CONCAT('SELECT * FROM users WHERE name = \'', name, '\'');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DROP PROCEDURE IF EXISTS registerUser;

CREATE PROCEDURE registerUser(IN reg_name VARCHAR(255), IN reg_username VARCHAR(255), IN reg_password VARCHAR(255), IN reg_planet VARCHAR(255))
BEGIN
    INSERT INTO users (name, username, password, planet) 
    VALUES (reg_name, reg_username, reg_password, reg_planet);
END //

DROP PROCEDURE IF EXISTS loginUser;

CREATE PROCEDURE loginUser(IN login_username VARCHAR(255), IN login_password VARCHAR(255))
BEGIN
    SELECT name, planet, id 
    FROM users 
    WHERE username = login_username AND password = login_password;
END //


DROP PROCEDURE IF EXISTS editName;

CREATE PROCEDURE editName(IN edit_id INT, IN new_name VARCHAR(255))
BEGIN
    UPDATE users
    SET name = new_name
    WHERE id = edit_id;
END //

DELIMITER ;

GRANT EXECUTE ON PROCEDURE interstellar.searchUser TO 'root'@'127.0.0.1';
GRANT EXECUTE ON PROCEDURE interstellar.registerUser TO 'root'@'127.0.0.1';
GRANT EXECUTE ON PROCEDURE interstellar.loginUser TO 'root'@'127.0.0.1';
GRANT EXECUTE ON PROCEDURE interstellar.editName TO 'root'@'127.0.0.1';
