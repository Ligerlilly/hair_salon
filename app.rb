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
	@stylist = Stylist.find(params['id'].to_i)
	erb :stylist
end

get '/clients/:id' do
	@client = Client.find(params['id'].to_i)
	erb :client
end
