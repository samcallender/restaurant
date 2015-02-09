require 'bundler'
Bundler.require

enable :sessions

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  database: "restaurant_db"
)

require_relative 'models/menuitem'
require_relative 'models/order'
require_relative 'models/party'

# MENU ITEMS

get '/menuitems' do
	@menuitems = Menuitem.all
	erb :'menuitems/index'
end

get '/menuitems/new' do
	erb :'menuitems/new'
end

get '/menuitems/:id' do |id|
	@menuitem = Menuitem.find(id)
	erb :'menuitems/show'
end

post '/menuitems' do
	menuitem = Menuitem.create(params[:menuitem])
	redirect to "/menuitems/#{menuitem.id}"
end

get '/menuitems/:id/edit' do |id|
	@menuitem = Menuitem.find(id)
	erb :'menuitems/edit'
end

patch '/menuitems/:id' do
	menuitem = Menuitem.find(params[:id])
	menuitem.update(params[:menuitem])
	redirect to "/menuitems/#{params[:id]}"
end

delete '/menuitems/:id' do
	menuitem = Menuitem.find(params[:id])
	menuitem.destroy
	redirect to "/menuitems"
end


# PARTIES

get '/parties' do
	@parties = Party.all
	erb :'parties/index'
end

get '/parties/new' do
	erb :'parties/new'
end

get '/parties/:id' do |id|
	@party = Party.find(id)
	erb :'parties/show'
end 

post '/parties' do
	party = Party.create(params[:party])
	redirect to "/parties/#{party.id}"
end

get '/parties/:id/edit' do |id|
	@party = Party.find(id)
	erb :'parties/edit'
end

patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect to "/parties/#{params[:id]}"
end

delete '/parties/:id' do
	party = Party.find(params[:id])
	party.destroy
	redirect to "/parties" 
end

# begin the clusterfuck of orders

get '/orders/:id/new' do |id|
	@party = Party.find(id)
  	@menuitems = Menuitem.all
	erb :'orders/new'
end

post '/orders/:id/new' do
  	order = Order.create(params[:order])
  	party = Party.find(order.party_id)
  	redirect to "/orders/#{order.party_id}/new" 
end

delete '/orders/:id' do |id|
  menuitem_id = params[:menuitem]["id"]
  order = Order.find_by(menuitem_id: menuitem_id, party_id: id)
  order.destroy
  party = Party.find(id)
  redirect to "/orders/#{party.id}/new"
end

 # Default routes

get '/welcome' do
  erb :"static/welcome"
end

get '/*' do
    redirect to("/welcome")
end

 # Console
get '/console' do
    Pry.start(binding)
    ""
end