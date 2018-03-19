require 'json'

module HealthyRack
  class App
    HEADERS = {
      'Content-Type' => 'application/json; charset=UTF-8'
    }.freeze

    class << self
      def call(_env)
        failed_checks = HealthyRack.config.checks.reject(&:call)
        if failed_checks.any?
          [500, HEADERS.dup, [error_response_body(failed_checks)]]
        else
          [200, HEADERS.dup, [successful_response_body]]
        end
      end

      private

      def successful_response_body
        JSON.generate(healthy: true)
      end

      def error_response_body(failed_checks)
        JSON.generate(
          healthy: false,
          failed_checks: failed_checks.map(&:name)
        )
      end
    end
  end
end
