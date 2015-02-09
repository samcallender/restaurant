class Party < ActiveRecord::Base
	has_many :orders
	has_many :menuitems, through: :orders
end