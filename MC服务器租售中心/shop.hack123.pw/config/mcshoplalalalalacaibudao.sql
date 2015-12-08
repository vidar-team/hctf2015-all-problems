DROP DATABASE IF EXISTS mcshop;

CREATE DATABASE mcshop DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

# 管理员表
CREATE TABLE mcshop.mcshop_admin (
  id INT(10) NOT NULL  AUTO_INCREMENT,
  username VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  password VARCHAR(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  email VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  token VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  level VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO mcshop.mcshop_admin (id, username, password, email, token, level)  VALUES
  # please change the password to your own!!!
  ( # password: mcshop_admin!@#
    1,'mcshop_admin','6471ed64f102429d4bdfdcd3840645ca','mcshop_admin@hack123.xyz',
    'nUWg5R3M7IxA3lfZk4VT0cgsC9saUBBSU55YCxl3FLUr4FwQEV4Zq1mIvfQzo3DN','0'),
  ( # password: mcshop_sale!@#
      2, 'mcshop_sale', '4909ccbd5734add765b4be6668f8c48c', 'mcshop_sale@hack123.xyz',
      'QaJuOdcB9xN1BFLfbk98D8jMLO7VaOZkpTyFCqrWL2nF718bp9sS4ACsh6POnhlG','1'
  );

# 用户表
CREATE TABLE mcshop.mcshop_user (
  id INT(10) NOT NULL AUTO_INCREMENT,
  username VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  password VARCHAR(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  email VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  token VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  bank VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  history_bank VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB;

# delete the test data when you use this sql file in product env !!!
INSERT INTO mcshop.mcshop_user VALUES (
    1, 'test', '309031d05eb343448b725b09a3635f13','test@test.com',
    '7ClEs9RBtKJEuFSrxjpSLkNAqcFPc90Bh5eTfd0aj3V8jJWmvQzKBxjT56rhYbmp',
    '999999','2348'
);

# 服务器列表
CREATE TABLE mcshop.server_list (
  id INT(10) NOT NULL AUTO_INCREMENT,
  server_name VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  cpu VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  memory VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  harddisk VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  ssd VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  sum_number VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  inuse_number VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  left_number VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  price VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB;

INSERT INTO mcshop.server_list VALUES (
    1, 'server-a', '1', '1', '1024', '0', '100', '3', '97', '10'
), (
    2, 'server-b', '2', '2', '1024', '0', '300', '17', '283', '20'
),(
    3, 'server-c', '2', '3', '1024', '1', '300', '24', '276', '35'
),(
    4, 'server-d', '4', '4', '1024', '1', '200', '10', '190', '50'
),(
    5, 'server-e', '8', '8', '1024', '1', '70', '2', '68', '120'
),(
    6, 'server-f', '8', '16', '1024', '1', '40', '1', '39', '180'
);

# 购物车表
CREATE TABLE mcshop.cart (
  id INT(10) NOT NULL AUTO_INCREMENT,
  uid VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  username VARCHAR(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  server_id INT(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  price INT(10) COLLATE utf8mb4_general_ci NOT NULL,
  cnt INT(10) COLLATE utf8mb4_general_ci NOT NULL,
  sum_price INT(10) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (id)
) ENGINE = InnoDB;

# flag表
CREATE TABLE mcshop.flag (
  flag VARCHAR(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB;



