# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def assert_valid_value(value)
      raise ArgumentError, "Invalid value: #{value.inspect}" unless value.is_a?(self)
    end

    def cast(item)
      return item if item.is_a?(self)

      find(item)
    end
  end
end
