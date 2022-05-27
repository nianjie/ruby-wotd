require 'faraday'
require 'json'

class Client
  # The name of the environment variable to lookup a Firebase config.
  FIREBASE_CONFIG_ENV_VAR = "FIREBASE_CONFIG"
  USER_AGENT = "Ruby/#{RUBY_VERSION}"

  def initialize(**options)
    raise %Q[the environment `#{FIREBASE_CONFIG_ENV_VAR}' was not set.] unless ENV[FIREBASE_CONFIG_ENV_VAR]
    config = JSON.parse(ENV[FIREBASE_CONFIG_ENV_VAR])
    @root = config['databaseURL']
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
