require 'sinatra'
require './lib/stylist'
require './lib/client'
require 'pg'
require 'sinatra/reloader'
require 'pry'

DB = PG.connect({dbname: 'hair_salon'})


get '/'  do
	erb :index
end

get '/clients' do
	@clients = Client.all
  erb :clients
end

post '/clients' do
	@client = Client.new({ name: params['name'], id: nil, stylist_id: nil })
	@client.save
	redirect :clients
end

get '/clients/:id' do
	@client = Client.find(params['id'].to_i)
	erb :client
end

patch '/clients/:id' do
	@client = Client.find(params['id'].to_i)
	@client.update({name: params['name'], client_id: params['id'].to_i})
	redirect :clients
end

delete '/clients/:id' do
	@client = Client.find(params['id'].to_i)
	@client.destroy
	redirect :clients
end



get '/stylists' do
	@stylists = Stylist.all
	erb :stylists
end

post '/stylists' do
	@stylist = Stylist.new({ name: params['name'], id: nil })
	@stylist.save
	redirect :stylists
end

get '/stylists/:id' do
	@clients = Client.all
	@stylist = Stylist.find(params['id'].to_i)
	erb :stylist
end

patch "/stylists/:id" do
	@stylist = Stylist.find(params['id'].to_i)
	@stylist.update({name: params['name']})
	if params['client_id']
		@client = Client.find(params['client_id'].to_i)
		@client.update({name: @client.name, stylist_id: @stylist.id, client_id: params['client_id'].to_i})
	end
	redirect :stylists
end

delete '/stylists/:id' do
	@stylist = Stylist.find(params['id'].to_i)
	@stylist.destroy
	redirect :stylists
end
