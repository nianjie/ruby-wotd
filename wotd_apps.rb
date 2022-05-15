
class WotdApp
  def initialize
    @app = Rack::Builder.new(lambda {|env| [200, {}, ['OK, /']]}) do
      map '/chronological' do
        run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK, /chronological']] }
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
    end
  end
  
  def call(env)
    @app.call(env)
  end
end
