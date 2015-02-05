class Party < ActiveRecord::Base
	has_many :orders
	has_many :menu_items, through: :orders
end