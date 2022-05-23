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
        use Rack::ContentType, 'application/json'
        use Apps::JsonBody
        run Alphabet.new
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

  class Alphabet
    def call(env)
      words = env[Rack::PATH_INFO].split('/').reject(&:empty?)
      body = words.map { |word| 
        Dictionary.getWord(word)
      }
      [200, {}, body]
    end
  end
end
