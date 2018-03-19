require 'healthy_rack/check'
require 'healthy_rack/verify_class_definition'

module HealthyRack
  module Checks
    class Sequel < Check
      def verify
        VerifyClassDefinition.call('Sequel')
      end

      def call
        ::Sequel::Model.db.select(nil).first
        true
      rescue
        false
      end
    end
  end
end
