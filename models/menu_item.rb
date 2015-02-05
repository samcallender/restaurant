class Menu_item < ActiveRecord::Base
	has_many :orders
	has_many :partys, through: :orders
end