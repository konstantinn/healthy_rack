require 'healthy_rack/app'

module HealthyRack
  class Middleware
    def initialize(app, path:)
      @app = app
      @path = path
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.path_info == path
        App.call(env)
      else
        app.call(env)
      end
    end

    private

    attr_reader :app, :path
  end
end
