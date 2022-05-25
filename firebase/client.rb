require 'faraday'

class Client
  USER_AGENT = "Ruby/#{RUBY_VERSION}"
  def initialize(**options)
    @root = options[:databaseURL]
  end
  
  def get(location)
    location << '.json' unless location.end_with? '.json'
    connection.get(location)
  end

  def connection
    options = {
            headers: {
              Accept: "application/json; charset=utf-8",
              "Content-Type": "application/json; charset=utf-8",
              "User-Agent": USER_AGENT
            }
          }
    @connection ||= Faraday::Connection.new(@root, options) do |c|
      c.request :json
      c.response :json
      c.response :logger
      c.adapter Faraday.default_adapter
    end
  end
end
