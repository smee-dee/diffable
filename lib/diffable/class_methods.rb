module Diffable
  module ClassMethods
    def diffable?
      diffable_fields.present? and diffable_fields.is_a?(Array)
    end

    def diffable_fields
      @diffable_fields
    end

    def diffable_on(*fields)
      unless valid_fields?(fields)
        fail "Please provide an Array of fields to be diffable"
      end

      save_fields_as_array fields
    end

    def save_fields_as_array(fields)
    end

    def valid_fields?(fields)
      fields.class == Array or
        fields.class == Symbol or
        fields.class == String
    end
  end
end
