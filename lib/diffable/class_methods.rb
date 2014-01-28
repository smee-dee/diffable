module Diffable
  module ClassMethods
    attr_reader :diffable_fields

    def diffable?
      diffable_fields.present? and diffable_fields.is_a?(Array)
    end

    def diffable_on(*fields)
      unless valid_fields?(fields)
        fail 'Please provide an Array of fields to be diffable'
      end

      save_fields_as_array fields
    end

    def save_fields_as_array(fields)
    end

    def valid_fields?(fields)
      valid_parameter_types.include? fields.class
    end

    def valid_parameter_types
      [Array, Symbol, String, Hash]
    end
  end
end
