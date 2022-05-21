require 'sinatra'
require 'sinatra/json'
require './dic.rb'

get '/' do
  'Hello world!'
end

get '/wotd' do
  json Dictionary.wordOfTheDay
end
