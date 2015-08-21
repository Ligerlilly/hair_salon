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
  erb :clients
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
	erb :stylist
end

get '/clients/:id' do
	erb :client
end
