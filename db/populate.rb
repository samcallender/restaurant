require 'pg'
require 'pry'

init_orders = <<-SQL
CREATE TABLE orders(
	id				    SERIAL			PRIMARY KEY,
	party_id		  INTEGER 		NOT NULL,
	menuitem_id	  INTEGER			NOT NULL,
  notes         TEXT,
  complimentary BOOLEAN,	
	created_at		TIMESTAMP,
	updated_at		TIMESTAMP
	);
SQL


init_parties = <<-SQL
CREATE TABLE parties(
	id			    SERIAL			PRIMARY KEY,
	patrons		  INTEGER,
	paid 		    BOOLEAN			NOT NULL,
  table_id    INTEGER,
  notes       TEXT,
  bill_total  REAL,
	created_at	TIMESTAMP,
	updated_at	TIMESTAMP
	);
SQL


init_menuitems = <<-SQL
CREATE TABLE menuitems(
	id				    SERIAL			PRIMARY KEY,
	name			    TEXT			NOT NULL,
	menu_category	TEXT			NOT NULL,
	description		TEXT			NOT NULL,
	price			    REAL			NOT NULL,
	gluten_free		BOOLEAN			NOT NULL,
	nuts_free		  BOOLEAN			NOT NULL,
	dairy_free		BOOLEAN			NOT NULL,
	vegetarian		BOOLEAN			NOT NULL,
	vegan 			  BOOLEAN			NOT NULL,
	created_at		TIMESTAMP,
	updated_at		TIMESTAMP
	);
SQL

db = PG.connect( dbname: 'restaurant_db')

db.exec('DROP TABLE IF EXISTS orders')
db.exec('DROP TABLE IF EXISTS parties')
db.exec('DROP TABLE IF EXISTS menuitems')

db.exec(init_orders)
db.exec(init_parties)
db.exec(init_menuitems)

db.exec(<<-SQL)
   INSERT INTO
       orders (party_id, menuitem_id)
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
       parties (patrons, paid)
    VALUES
       (3, false),
       (3, true),
       (2, false),
       (2, true),
       (1, false)
   SQL


   db.exec(<<-SQL)
   INSERT INTO
       menuitems (name, menu_category, description, price, gluten_free, nuts_free, dairy_free, vegetarian, vegan)
    VALUES
       ('Green Salad', 'Small Plates', 'Mixed greens with our house ginger dressing', 5, true, true, true, true, true),
       ('Avocado Green Salad', 'Small Plates','Mixed greens with fresh sliced avocado', 7, true, true, true, true, true),
       ('Spicy Sashimi Salad', 'Small Plates', 'Spring mix, strip daikon, crab meat, masago, sesame dressing with salmon, tuna and white tuna', 13, true, true, true, false, false),
       ('Ocean Salad', 'Small Plates', 'green seaweed cooked in a mildly spicy sesame dressing', 5, true, true, true, true, true),
       ('Edamame', 'Small Plates', 'steamed soybeans with a sprinkle of sea salt', 5, true, true, true, true, true),
       ('Tempura Rock Shrimp', 'Small Plates', 'Served with 3 dipping sauces', 16, false, true, true, false, false),
       ('Cracklin Calamari Salad', 'Small Plates', 'With sweet thai chili sauce', 15, false, true, true, false, false),
       ('Beef Negimaki', 'Small Plates', 'Thin beef strips wrapped around scallions, pan seared', 7, true, true, true, false, false),
       ('Gyoza', 'Small Plates', 'Pan fried or steamed japanese moon dumplings', 7, false, true, true, false, false),
       ('Shrimp Shumai', 'Small Plates','(Choice of steamed or fried) shrimp dumplings', 8, false, true, true, false, false),
       ('Wasabi Pork Shumai', 'Small Plates', 'Choice of steamed or fried pork dumplings with wasabi wrap', 10, false, true, true, false, false),
       ('Crispy Flounder', 'Small Plates', 'Lightly fried then drizzled with a sesame, soy, garlic, ginger and scallion sauce', 14, false, true, true, false, false),
       ('Spicy Tuna Tartare', 'Small Plates', 'Chopped tuna with masago and scallions, mixed with a special spicy sauce', 14, true, true, true, false, false),
       ('Suzuki Carpaccio', 'Small Plates', 'Thinly sliced striped bass flash seared with hot sesame oil and olive oil; garnished with tobiko and scallions', 20, true, true, true, false, false),
       ('Shrimp and Lobster Spring Roll', 'Small Plates', 'Served with sweet thai chile dipping sauce', 9, true, true, true, false, false),
       ('Binny Roll', 'Special Features', 'shrimp tempura and avocado roll topped with spicy tuna; garnished with sweet soy and spicy sauce', 17, true, true, true, false, false),
       ('Kingdom of Eel Roll', 'Special Features', 'california roll with eel wrapped on top, garnished with sweet soy sauce, red hot sauce, creamy sauce, tobiko and scallions', 19, true, true, false, false, false),
       ('Trifena Roll', 'Special Features', 'shrimp tempura topped with eel, avocado and spacy tuna, garnished with sweet soy sauce, red hot sauce, creamy sauce, tobiko and scallions', 19, false, true, false, false, false),
       ('Green River Roll', 'Special Features','spicy tuna and shrimp tempura roll covered in green tea tempura flakes, topped with avocado and spicy lobster, garnished with tobiko and green tea sauce', 21, false, true, true, false, false),
       ('Torimy Roll', 'Special Features', 'Spicy tuna and eel roll topped with torched squid; garnished with sweet soy sauce, creamy sauce, spicy sauce, tobiko and scallions', 18, false, false, false, false, false),
       ('Arina Roll', 'Special Features', 'Crunchy tuna roll topped with avocado and spicy tuna; garnished with sweet soy sauce and red hot sauce', 19, true, true, true, false, false),
       ('White Tiger','Special Features', 'Mutsu (super white tuna), scallions, red hot sauce and masago roll topped with mutsu sashimi slices, then topped again with creamy mutsu and seared for texture; garnished with scallions, red tobiko, sweet soy sauce, cream sauce and red hot sauce', 20, true, true, true, false, false),
       ('Chirashi', 'Special Features', '2 pcs each: tuna, yellowtail, salmon, white fish, sawara, squid and white tuna - 1 pc each: eel, octopus and shrimp - served on a bed of sushi rice', 29, true, true, true, false, false),
       ('Hot Sake', 'Drinks', 'tradional dry sake served piping hot', 13, true, true, true, true, true),
       ('Black Honda', 'Drinks', 'Sobieski Raspberry Vodka, sake, Marie Brizzard Raspberry Liqeur, fresh lemon juice and a splash of sprite', 14, true, true, true, true, true),
       ('Hara Kiri', 'Drinks', 'Gekkeikan Sake, Sobieski Vodka, wasabi, siracha, worcestershire sauce and tomato juice', 12, true, true, true, true, true),
       ('Sparkling Cosmo', 'Drinks', 'Sobieski Vodka, Triple Sec, lime and cranberry juices, topped with sparkling wine', 10, true, true, true, true, true),
       ('Ginger Blossom', 'Drinks','Domaine de Canton Ginger Liqeur, Gekkeikan Sake, Sobieski Cytron Vodka and fresh lemon juice', 12, true, true, true, true, true),
       ('Lady Dragon', 'Drinks', 'Kai Lychee Vodka, Domaine de Canton Ginger Liqeur, melon Liqeur, pineapple juice and fresh lime juice', 12, true, true, true, true, true),
       ('The Kono Hito', 'Drinks', 'Tanqeray Gin, Campari and grapefruit juice', 10, true, true, true, true, true),
       ('Pink Bubbly', 'Drinks', 'Sobieski Vodka, pineapple and cranberry juice, topped with sparkling wine', 11, true, true, true, true, true),
       ('Margarita Falls', 'Drinks', 'Patron Reposado, Gekkeikan Sake, Patron Citronge and lime juice', 11, true, true, true, true, true),
       ('The Whisper', 'Drinks', 'Hangar Kaffe Lime, St. Germain and fresh lemon juice, served over sparkling wine', 11, true, true, true, true, true),
       ('Clementine Tropical', 'Drinks', 'Skyy Blood Orange Vodka and mango pineapple nectar', 11, true, true, true, true, true),
       ('Summer Punch', 'Drinks', 'Courvoisier C Cognac, grenadine, pineapple, cranberry and orange juice', 11, true, true, true, true, true)
  	 SQL