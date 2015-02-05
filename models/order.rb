class Order < ActiveRecord::Base
	belongs_to :menu_items
	belongs_to :partys
end