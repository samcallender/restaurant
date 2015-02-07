class Menu_item < ActiveRecord::Base
	has_many :orders
	has_many :parties, through: :orders
end