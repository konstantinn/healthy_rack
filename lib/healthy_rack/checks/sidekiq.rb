require 'healthy_rack/check'
require 'healthy_rack/verify_class_definition'

module HealthyRack
  module Checks
    class Sidekiq < Check
      def verify
        VerifyClassDefinition.call('Sidekiq')
      end

      def call
        ::Sidekiq.redis_info
        true
      rescue
        false
      end
    end
  end
end
