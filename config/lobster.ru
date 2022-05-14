require 'rack/lobster'
require './wotd_apps.rb'

rootApp = Rack::Builder.new do
  use Rack::Reloader
  map "/lobster" do
    run Rack::Lobster.new
  end
  map "/wotd" do
    run WotdApp.new
  end
end

run rootApp