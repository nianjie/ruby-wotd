require 'rack/lobster'
require './wotd_apps.rb'

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