/*
		生成随机密码可以使用 MD5('string') 也可以使用 uuid()
    uuid() 生成的是36位字符串, 需要截取长度 可以选择用left('string', len) 或 right('string', len)
    ceiling() 返回大于x的最小整数, rand()*120 返回0到120之间的随机数, 所以ceiling(rand()*120) 返回1-120之间的随机数 
 */
INSERT tb18 (username, password, age, sex) values('A', MD5('A123456'),20,1);
INSERT tb18 (username, password, age, sex) values(char(66), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(67), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(68), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(69), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(70), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(71), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(72), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(73), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(74), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(75), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(76), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(77), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(78), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(79), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(80), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(81), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(82), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(83), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(84), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(85), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(86), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(87), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(88), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(89), left(uuid(),32), ceiling(rand()*120), 1);
INSERT tb18 (username, password, age, sex) values(char(90), left(uuid(),32), ceiling(rand()*120), 1);
