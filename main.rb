require 'rubygems'
require 'sinatra'
require "sinatra/reloader"

set :sessions, true

BLACKJACK_AMOUNT = 21
DEALER_MIN_HIT = 17
PLAYER_STARTING_MONEY = 500

helpers do
  def calculate_total(cards)
    values = cards.map{|card| card[0] }

    total = 0
    values.each do |value|
      if value == "Ace"
        total += 11
      elsif value.to_i == 0
        total += 10
      else
        total += value.to_i
      end
    end

    values.select{|value| value == "Ace"}.count.times do
      total -= 10 if total > BLACKJACK_AMOUNT
    end

    total
  end

  def reset_deck
    suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
    cards = ["2", "3", "4", "5", "6", "7", "8", "9",
             "10", "Jack", "Queen", "King", "Ace"]

    session[:deck] = cards.product(suits).shuffle!
  end

  def card_image(card)
    "<img src='/images/cards/#{card[1].downcase}_#{card[0].downcase}.jpg' class='card_image'>"
  end

  def strongly(msg)
    "<strong>#{msg}</strong>"
  end

  def update_money(result)
    if result == "win"
      session[:player_money] += session[:bet_amount]
    elsif result == "lose"
      session[:player_money] -= session[:bet_amount]
    end
  end

  def game_over?
    dealer_total = calculate_total(session[:dealer_cards])
    player_total = calculate_total(session[:player_cards])

    if (dealer_total == BLACKJACK_AMOUNT) && (player_total == BLACKJACK_AMOUNT)
      @success = strongly("#{session[:player_name]} and Dealer hit blackjack!")
      update_money "tie"
      true
    elsif player_total == BLACKJACK_AMOUNT
      @success = strongly("#{session[:player_name]} hit blackjack!")
      update_money "win"
      true
    elsif dealer_total == BLACKJACK_AMOUNT
      @error = strongly("Dealer hit blackjack!")
      update_money "lose"
      true
    elsif player_total > BLACKJACK_AMOUNT
      @error = "Sorry, it looks like " + strongly("#{session[:player_name]} busted.")
      update_money "lose"
      true
    elsif dealer_total > BLACKJACK_AMOUNT
      @success = "The " + strongly("dealer busted.")
      update_money "win"
      true
    else
      false
    end
  end
end

get '/' do
  if (session[:player_name]) && (session[:player_money] > 0)
    redirect '/bet'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  if (params[:player_name] == nil) || (params[:player_name].empty?)
    @error = "Name is required"
    halt erb(:new_player)
  end

  if !params[:player_name].match(/^[a-zA-Z]+( [a-zA-Z]+)*$/)
    @error = "Special characters and extra whitespace not allowed"
    halt erb(:new_player)
  end

  session[:player_name] = params[:player_name]
  session[:player_money] = PLAYER_STARTING_MONEY
  redirect '/bet'
end

get '/bet' do
  if (session[:player_name]) && (session[:player_money] > 0)
    session[:bet_amount] = nil
    erb :bet
  else
    redirect '/new_player'
  end
end

post '/bet' do
  if (params[:bet_amount] == nil) || (params[:bet_amount].empty?)
    @error = "Bet is required"
    halt erb(:bet)
  end

  bet_amount = params[:bet_amount].to_i

  if (bet_amount == 0) || (bet_amount > session[:player_money])
    @error = "Please bet between $1-$#{session[:player_money]}"
    halt erb(:bet)
  end

  session[:bet_amount] = bet_amount
  redirect '/game'
end

get '/game' do
  if(session[:player_name] == nil) || (session[:player_money] == 0)
    redirect '/new_player'
  end

  session[:turn] = session[:player_name]

  reset_deck
  session[:dealer_cards] = []
  session[:player_cards] = []

  2.times do
    session[:dealer_cards] << session[:deck].pop
    session[:player_cards] << session[:deck].pop
  end

  if game_over?
    erb :result
  else
    @success = "Welcome #{session[:player_name]}!"
    @show_hit_and_stay = true
    erb :game
  end
end

post '/game/player/hit' do
  session[:player_cards] << session[:deck].pop
  if game_over?
    erb :result, layout: false
  else
    @success = "Welcome #{session[:player_name]}!"
    @show_hit_and_stay = true
    erb :game, layout: false
  end
end

post '/game/player/stay' do
  redirect '/game/dealer'
end

get '/game/dealer' do
  session[:turn] = "Dealer"

  dealer_total = calculate_total(session[:dealer_cards])

  if dealer_total < DEALER_MIN_HIT
    @success = "Dealer chooses to hit."
    erb :game, layout: false
  else
    redirect '/game/result'
  end
end

post '/game/dealer/hit' do
  session[:dealer_cards] << session[:deck].pop
  if game_over?
    erb :result, layout: false
  elsif calculate_total(session[:dealer_cards]) < DEALER_MIN_HIT
    @success = "Dealer chooses to hit again."
    erb :game, layout: false
  else
    redirect '/game/result'
  end
end

get '/game/result' do
  dealer_total = calculate_total(session[:dealer_cards])
  player_total = calculate_total(session[:player_cards])

  if dealer_total > player_total
    @error = strongly("Dealer wins!")
    update_money "lose"
  elsif dealer_total < player_total
    @success = strongly("#{session[:player_name]} wins!")
    update_money "win"
  else
    @success = "It's a " + strongly("push.")
    update_money "tie"
  end

  erb :result, layout: false
end

get '/end' do
  @player_name = session[:player_name]
  @player_money = session[:player_money]
  session.clear
  erb :end
end