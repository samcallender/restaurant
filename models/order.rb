class Order < ActiveRecord::Base
	belongs_to :menuitem
	belongs_to :party
end