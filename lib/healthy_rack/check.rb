require 'healthy_rack/utils'

module HealthyRack
  class Check
    def verify; end

    def name
      class_name = self.class.name
      raise NotImplementedError if class_name.nil? # Anonymous Classes

      demodulized = Utils::String.demodulize(class_name)
      Utils::String.underscore(demodulized)
    end

    def call
      raise NotImplementedError
    end

    def ==(other)
      self.class == other.class && name == other.name
    end
    alias eql? ==

    def hash
      name.hash
    end
  end
end
