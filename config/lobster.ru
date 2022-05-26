require 'rack/lobster'
require './wotd_apps.rb'

port ENV['PORT']|| 9292

use Rack::Reloader
rootApp = Rack::Builder.new do
  map "/lobster" do
    run Rack::Lobster::LambdaLobster
  end
  map "/wotd" do
    run WotdApp.new
  end
end

run rootApp