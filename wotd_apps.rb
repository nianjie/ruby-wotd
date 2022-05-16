require './apps.rb'
require './dic.rb'

class WotdApp
  def initialize
    @app = Rack::Builder.new do
      map '/chronological' do
        use Rack::ContentType, 'application/json'
        use Apps::JsonBody
        map '/today' do
          run Chrono.new(true)
        end
        run Chrono.new
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

  class Chrono
    def initialize(is_today = false)
      @is_today = is_today
    end

    def call(env)
      begin
        date = @is_today ? Date.today : Date.strptime(env[Rack::PATH_INFO], '/%Y/%m/%d')
        body = [Dictionary.wordOfTheDay(date)]
      rescue Date::Error
        body = [{'error': 'Invalid date. Specify date in /yyyy/mm/dd format.'}]
      end
      [200, {}, body]
    end
  end
end
