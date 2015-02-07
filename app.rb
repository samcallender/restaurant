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
get '/console' do
    Pry.start(binding)
    ""
end

# MENU ITEMS

get '/menu_items' do
	@menu_items = Menu_item.all
	erb :'menu_items/index'
end

get '/menu_items/new' do
	erb :'menu_items/new'
end

get '/menu_items/:id' do |id|
	@menu_item = Menu_item.find(id)
	erb :'menu_items/show'
end

post '/menu_items' do
	menu_item = Menu_item.create(params[:menu_item])
	redirect to "/menu_items/#{menu_item.id}"
end

get '/menu_items/:id/edit' do |id|
	@menu_item = Menu_item.find(id)
	erb :'menu_items/edit'
end

patch '/menu_items/:id' do
	menu_item = Menu_item.find(params[:id])
	menu_item.update(params[:menu_item])
	redirect to "/menu_items/#{params[:id]}"
end

delete '/menu_items/:id' do
	menu_item = Menu_item.find(params[:id])
	menu_item.destroy
	redirect to "/menu_items"
end


# PARTIES

get '/partys' do
	@parties = Party.all
	erb :'partys/index'
end

get '/partys/new' do
	erb :'partys/new'
end

get '/partys/:id' do |id|
	@party = Party.find(id)
	erb :'partys/show'
end 

post '/partys' do
	party = Party.create(params[:party])
	redirect to "/partys/#{party.id}"
end

get '/partys/:id/edit' do |id|
	@party = Party.find(id)
	erb :'partys/edit'
end

patch '/partys/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect to "/partys/#{params[:id]}"
end

delete '/partys/:id' do
	party = Party.find(params[:id])
	party.destroy
	redirect to "/partys" 
end

# begin the clusterfuck of orders

get '/orders/:id/new' do |id|
	@party = Party.find(id)
  	@menu_items = Menu_item.all
	erb :'orders/new'
end

post '/orders/:id/new' do
  	order = Order.create(params[:order])
  	party = Party.find(order.party_id)
  	redirect to "/orders/#{order.party_id}/new" 
end

 # Default routes

get '/welcome' do
  erb :"static/welcome"
end

get '/*' do
    redirect to("/welcome")
end