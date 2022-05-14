require 'rack'

class WotdApp
  def initialize
    @app = Rack::Builder.new do
      use Rack::ContentType
      map '/' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /']] }
      end
      
      map '/chronological' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /chronological']] }
      end
    end
  end
  
  def call(env)
    @app.call(env)
  end
end
