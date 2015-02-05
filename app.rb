require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant_db"
)

require_relative 'models/menu_item'
require_relative 'models/order'
require_relative 'models/party'

 # Console
get "/console" do
    Pry.start(binding)
    ""
end

# MENU ITEMS
get "/menu_items" do
	@menu_items = Menu_item.all

	erb :'menu_items/index'
end

get "menu_items/:id" do

	erb :'menu_items/show'
end

# PARTYS
get "/partys" do

	erb :'partys/index'
end

get "partys/:id"

	erb :'partys/show'
end 

 # Default route
  get "/welcome" do
    erb :"static/welcome"
end

get "/*" do
    redirect to("/welcome")
end