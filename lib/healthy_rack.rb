require 'healthy_rack/middleware'
require 'healthy_rack/app'
require 'healthy_rack/configuration'
require 'healthy_rack/errors'

require 'healthy_rack/checks/active_record'
require 'healthy_rack/checks/redis'
require 'healthy_rack/checks/sidekiq'
require 'healthy_rack/checks/sequel'

module HealthyRack
  class << self
    def middleware
      Middleware
    end

    def app
      App
    end

    def config
      @config ||= Configuration.new
    end

    def reset_config
      config.reset
    end

    def configure
      yield(config)
    end
  end
end
