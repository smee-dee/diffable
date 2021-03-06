module Diffable
  module ClassMethods
    def diffable?
      @diffable_fields.is_a?(Array) and @diffable_fields.size > 0
    end

    def diffable_on(*fields)
      fields = fields.flatten
      unless fields.size > 0 and valid_fields?(fields)
        fail 'Please provide an Array of fields to be diffable'
      end

      @diffable_fields = fields
    end

    def diffable_fields(current = @diffable_fields)
      return [] unless diffable?

      current = [current] unless current.is_a?(Array)
      result  = []

      current.each do |field|
        if field.is_a?(Hash)
          values = field.values.first
          values = [values] unless values.is_a?(Array)
          values.each do |value|
            result << [field.keys.first] + diffable_fields(value).flatten
          end
        else
          result << field.to_sym
        end
      end

      result
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
