require 'rack'

class WotdApp
  def initialize
    @app = Rack::Builder.new do
      map '/' do
        use Rack::ContentType
        run lambda { |env| [200, {}, ['OK, /']] }
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
