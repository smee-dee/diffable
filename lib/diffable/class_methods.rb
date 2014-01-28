module Diffable
  module ClassMethods
    attr_reader :diffable_fields

    def diffable?
      diffable_fields.present? and diffable_fields.is_a?(Array)
    end

    def diffable_on(*fields)
      unless fields.present? and valid_fields?(fields)
        fail 'Please provide an Array of fields to be diffable'
      end

      save_fields_as_array fields
    end


    def save_fields_as_array(fields)
      @diffable_fields = fields
    end

    def valid_fields?(fields)
      fields.map do |field|
        valid_parameter_types.include? field.class
      end.all?
    end

    def valid_parameter_types
      [Symbol, String, Hash]
    end
  end
end
