require './apps.rb'
require './dic.rb'

class WotdApp
  def initialize
    @app = Rack::Builder.new do
      map '/chronological' do
        map '/today' do
          run Apps.JSON(Dictionary.wordOfTheDay())
        end
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, specify the date in the path.']] }
      end
      map '/alphabetical' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /alphabetical']] }
      end
      map '/count' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /count']] }
      end
      map '/random' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /random']] }
      end
      run lambda {|env| [200, {}, ['OK, /']]}
    end
  end
  
  def call(env)
    @app.call(env)
  end
end
