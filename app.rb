require 'bundler'
Bundler.require

enable :sessions

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

get "/menu_items/new" do

	erb :'menu_items/new'
end

get "/menu_items/:id" do |id|
	@menu_item = Menu_item.find(id)

	erb :'menu_items/show'
end

post "/menu_items" do
	menu_item = Menu_item.create(params[:menu_item])

	redirect to "/menu_items/#{menu_item.id}"
end

get "/menu_items/:id/edit" do |id|
	@menu_item = Menu_item.find(id)

	erb :'menu_items/edit'
end

patch '/menu_items/:id' do
	menu_item = Menu_item.find(params[:id])
	menu_item.update(params[:menu_item])

	redirect to "/menu_items/#{params[:id]}"
end

delete "/menu_items/:id" do
	menu_item = Menu_item.find(params[:id])
	menu_item.destroy

	redirect to "/menu_items"
end


# PARTYS

get "/partys" do
	@partys = Party.all

	erb :'partys/index'
end

get "/partys/:id" do

	erb :'partys/show'
end 



 # Default route
  get "/welcome" do
    erb :"static/welcome"
end

get "/*" do
    redirect to("/welcome")
end