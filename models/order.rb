class Order < ActiveRecord::Base
	belongs_to :menu_item
	belongs_to :party
end