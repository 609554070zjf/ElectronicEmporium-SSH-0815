
--商品类别表 t_goods_type
create table t_goods_type(
	goods_type_id char(32), --商品类别id
	goods_type_name varchar(30) not null,--商品类别名称
	goods_type_parentId int, --父类别
	goods_type_active char(1) default 1, --是否有效
	constraint T_GOODS_TYPE_PK primary key(goods_type_id),
	constraint T_GOODS_TYPE_FK1 FOREIGN KEY(goods_type_parentId) references t_goods_type(goods_type_id),
);

-- 商品表 t_goods 
CREATE TABLE t_goods(
	goods_id CHAR(32),
	goods_name VARCHAR(30),
	goods_price NUMERIC(7,2) DEFAULT 0.00,
	isEnough CHAR(1) DEFAULT 1,
	goods_desc VARCHAR(255),
	goods_cnt NUMERIC DEFAULT 0,
	goods_pic MEDIUMBLOB,
	goods_parent_type CHAR(32);
	goods_sub_type CHAR(32);
	CONSTRAINT T_GOODS_TYPE_PK PRIMARY KEY(goods_id)
	CONSTRAINT FK_PARENT_GOODS FOREIGN KEY(goods_parent_type) REFERENCES t_goods_type(goods_type_id),
    CONSTRAINT FK_SUB_GOODS FOREIGN KEY(goods_sub_type) REFERENCES t_goods_type(goods_type_id)
);

-- 用户/管理员账户表
CREATE TABLE t_user(
	 user_id INT NOT NULL,
 	 user_name VARCHAR(15) NOT NULL,
	 PASSWORD VARCHAR(15) NOT NULL,
	 user_sex CHAR(1) NOT NULL DEFAULT 1,		 
	 identify CHAR(1) NOT NULL DEFAULT 1,
	 real_name VARCHAR(10) NOT NULL,
	 birthday DATE NOT NULL,
	 email VARCHAR(40) NOT NULL,
	 phone VARCHAR(15) NOT NULL,
	 address VARCHAR(100) NOT NULL,
	 post_code CHAR(6) NOT NULL,
	 freezes char(1) NOT NULL DEFAULT '0',
	 CONSTRAINT T_USER_PK PRIMARY KEY(user_id)
)

-- 购物车表
create table t_buycar(
	buy_car_id int not null,
	user_id int not null,
	goods_id char(32) not null,
	goods_cnt NUMERIC not null default 0,
	money NUMERIC(8,2) not null default 0.0,
	constraint T_BUYCAR_PK primary key(buy_car_id),
	constraint FK_USER_BUYCAR foreign key(user_id) references t_user(user_id),
	constraint FK_GOODS_BUYCAR foreign key(goods_id) references t_goods(goods_id)
)

-- 订单表
CREATE TABLE t_order(
	order_id INT NOT NULL,
	user_id INT NOT NULL,
	order_date DATE NOT NULL,
	pay_type CHAR(1) NOT NULL,
	post_type CHAR(1) NOT NULL,
	goodstype_cnt NUMERIC NOT NULL DEFAULT 0,
	goods_cnt NUMERIC NOT NULL DEFAULT 0,
	total_money NUMERIC NOT NULL DEFAULT 0.0,
	check_state CHAR(1) NOT NULL DEFAULT 1,
	order_state CHAR(1) NOT NULL DEFAULT 1,
	receiver_name VARCHAR(15) NOT NULL,
	receiver_phone VARCHAR(15) NOT NULL,
	receiver_address VARCHAR(100) NOT NULL,
	receiver_email VARCHAR(40) NOT NULL,
	receiver_postcode CHAR(6) NOT NULL,
	CONSTRAINT T_ORDER_PK PRIMARY KEY(order_id),
	CONSTRAINT FK_ORDER_User FOREIGN KEY(user_id) REFERENCES t_user(user_id)
)

-- 订单条目表
CREATE TABLE t_order_item(
	order_item_id INT NOT NULL,
	order_id INT NOT NULL,
	goods_id CHAR(32) NOT NULL,
	goods_name VARCHAR(30) NOT NULL,
	goods_desc VARCHAR(255),
	goods_cnt NUMERIC NOT NULL DEFAULT 0,
	money NUMERIC NOT NULL DEFAULT 0.0,
	goods_price NUMERIC NOT NULL DEFAULT 0.0,
	CONSTRAINT T_ORDER_ITEM_PK PRIMARY KEY(order_item_id),
	CONSTRAINT FK_ORDER_ORDERITEM FOREIGN KEY(order_id) REFERENCES t_order(order_id)
)