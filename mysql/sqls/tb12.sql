CREATE TABLE IF NOT EXISTS tdb_goods_brands(
	brand_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	brand_name VARCHAR(40) NOT NULL
	) SELECT brand_name FROM tdb_goods GROUP BY brand_name;
