module HealthyRack
  module Utils
    # https://github.com/hanami/utils/blob/v1.1.2/lib/hanami/utils/string.rb
    class String
      NAMESPACE_SEPARATOR = '::'.freeze
      UNDERSCORE_SEPARATOR = '/'.freeze
      UNDERSCORE_DIVISION_TARGET = '\1_\2'.freeze

      def self.demodulize(input)
        ::String.new(input.to_s).split(NAMESPACE_SEPARATOR).last
      end

      def self.underscore(input)
        string = ::String.new(input.to_s)
        string.gsub!(NAMESPACE_SEPARATOR, UNDERSCORE_SEPARATOR)
        string.gsub!(NAMESPACE_SEPARATOR, UNDERSCORE_SEPARATOR)
        string.gsub!(/([A-Z\d]+)([A-Z][a-z])/, UNDERSCORE_DIVISION_TARGET)
        string.gsub!(/([a-z\d])([A-Z])/, UNDERSCORE_DIVISION_TARGET)
        string.gsub!(/[[:space:]]|\-/, UNDERSCORE_DIVISION_TARGET)
        string.downcase
      end
    end
  end
end
