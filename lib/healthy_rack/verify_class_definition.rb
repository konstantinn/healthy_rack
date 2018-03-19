module HealthyRack
  class VerifyClassDefinition
    def self.call(claz)
      Object.const_get(claz)
    rescue NameError
      raise Errors::UndefinedClassError,
            "#{claz} is not defined. Is corresponding gem installed?"
    end
  end
end
