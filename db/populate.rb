require 'pg'
require 'pry'

init_orders = <<-SQL
CREATE TABLE orders(
	id				SERIAL			PRIMARY KEY,
	party_id		INTEGER 		NOT NULL,
	menu_item_id	INTEGER			NOT NULL,	
	created_at		TIMESTAMP,
	updated_at		TIMESTAMP
	);
SQL


init_partys = <<-SQL
CREATE TABLE partys(
	id			SERIAL			PRIMARY KEY,
	patrons		INTEGER,
	paid 		BOOLEAN			NOT NULL,
	created_at	TIMESTAMP,
	updated_at	TIMESTAMP
	);
SQL


init_menu_items = <<-SQL
CREATE TABLE menu_items(
	id				serial			PRIMARY KEY,
	name			TEXT			NOT NULL,
	menu_category	TEXT			NOT NULL,
	description		TEXT			NOT NULL,
	price			REAL			NOT NULL,
	gluten_free		BOOLEAN			NOT NULL,
	nuts_free		BOOLEAN			NOT NULL,
	dairy_free		BOOLEAN			NOT NULL,
	vegetarian		BOOLEAN			NOT NULL,
	vegan 			BOOLEAN			NOT NULL,
	created_at		TIMESTAMP,
	updated_at		TIMESTAMP
	);
SQL

db = PG.connect( dbname: 'restaurant_db')

db.exec('DROP TABLE IF EXISTS orders')
db.exec('DROP TABLE IF EXISTS partys')
db.exec('DROP TABLE IF EXISTS menu_items')

db.exec(init_orders)
db.exec(init_partys)
db.exec(init_menu_items)

db.exec(<<-SQL)
   INSERT INTO
       orders (party_id, menu_item_id)
    VALUES
       (1, 1),
       (1, 6),
       (1, 4),
       (1, 8),
       (2, 8),
       (2, 7),
       (2, 3),
       (2, 5),
       (3, 8),
       (3, 6),
       (3, 2),
       (3, 2),
       (4, 7),
       (4, 5),
       (4, 8),
       (4, 5),
       (4, 3),
       (5, 2),
       (5, 6),
       (5, 7)
   SQL

   db.exec(<<-SQL)
   INSERT INTO
       partys (patrons, paid)
    VALUES
       (3, false),
       (3, true),
       (2, false),
       (2, true),
       (1, false)
   SQL


   db.exec(<<-SQL)
   INSERT INTO
       menu_items (name, menu_category, description, price, gluten_free, nuts_free, dairy_free, vegetarian, vegan)
    VALUES
       ('Ocean Salad', 'Small Plates', 'green seaweed cooked in a mildly spicy sesame dressing', 5, true, true, true, true, true),
       ('Edamame', 'Small Plates', 'steamed soybeans with a sprinkle of sea salt', 5, true, true, true, true, true),
       ('Binny Role', 'Special Features', 'shrimp tempura and avocado roll topped with spicy tuna; garnished with sweet soy and spicy sauce', 17, true, true, true, false, false),
       ('Kingdom of Eel Roll', 'Special Features', 'california roll with eel wrapped on top, garnished with sweet soy sauce, red hot sauce, creamy sauce, tobiko and scallions', 19, true, true, false, false, false),
       ('Trifena Roll', 'Special Features', 'shrimp tempura topped with eel, avocado and spacy tuna, garnished with sweet soy sauce, red hot sauce, creamy sauce, tobiko and scallions', 19, false, true, false, false, false),
       ('Green River Roll', 'Special Features','spicy tuna and shrimp tempura roll covered in green tea tempura flakes, topped with avocado and spicy lobster, garnished with tobiko and green tea sauce', 21, false, true, true, false, false),
       ('Hot Sake', 'Drinks', 'tradional dry sake served piping hot', 13, true, true, true, true, true),
       ('Black Honda', 'Drinks', 'Sobieski Raspberry Vodka, sake, Marie Brizzard Raspberry Liqeur, fresh lemon juice and a splash of sprite', 14, true, true, true, true, true)
  	 SQL