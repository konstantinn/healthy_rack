require 'healthy_rack/check'
require 'healthy_rack/verify_class_definition'

module HealthyRack
  module Checks
    class Redis < Check
      def initialize(redis_url)
        @redis_url = redis_url
      end

      def verify
        VerifyClassDefinition.call('Redis')
      end

      def call
        response = ::Redis.new(url: redis_url).ping
        response == 'PONG'
      rescue
        false
      end

      private

      attr_reader :redis_url
    end
  end
end
