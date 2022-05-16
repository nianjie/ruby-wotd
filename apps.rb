module Apps
  require 'json'

  def j(json)
    Rack::Builder.app do
      use Rack::ContentType, 'application/json'
      json = JSON.generate(json) unless json.instance_of?(::String)
      run lambda { |env| [ 200, {}, [json] ] }
    end
  end

  module_function :j
end