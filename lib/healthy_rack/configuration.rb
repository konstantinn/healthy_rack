require 'set'

module HealthyRack
  class Configuration
    attr_reader :checks

    def initialize
      setup
    end

    def reset
      setup
    end

    def add_checks(*checks_to_add)
      checks_to_add.each do |check|
        check.verify
        checks.add(check)
      end
    end

    private

    def setup
      @checks = Set.new
    end
  end
end
