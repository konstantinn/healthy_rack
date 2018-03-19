require 'healthy_rack/check'
require 'healthy_rack/verify_class_definition'

module HealthyRack
  module Checks
    class ActiveRecord < Check
      def verify
        VerifyClassDefinition.call('ActiveRecord')
      end

      def call
        ::ActiveRecord::Migrator.current_version
        true
      rescue
        false
      end
    end
  end
end
