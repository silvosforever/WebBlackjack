require 'rubygems'
require 'sinatra'
require "sinatra/reloader"

set :sessions, true

helpers do
  def calculate_total(cards)
  end
end

get '/' do
  erb :set_name
end

post '/set_name' do
  session[:player_name] = params[:player_name]
  redirect '/game'
end

get '/game' do
  session[:deck] = [['2', 'Hearts'], ['3', 'Diamonds']]
  session[:player_cards] = []
  session[:player_cards] << session[:deck].pop
  session[:player_cards] << session[:deck].pop
  erb :game
end