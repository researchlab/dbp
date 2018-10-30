CREATE TABLE IF NOT EXISTS tb3(
	logrecord_id INT(11) NOT NULL AUTO_INCREMENT,
	user_name VARCHAR(100) DEFAULT NULL,
	operation_time DATETIME DEFAULT NULL,
	logrecord_operation VARCHAR(100) DEFAULT NULL,
	PRIMARY KEY (logrecord_id),
	KEY tb3_user_name (user_name)
	);
