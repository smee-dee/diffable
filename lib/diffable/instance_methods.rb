module Diffable
  module InstanceMethods
    def diff
    end

    def diff_fields(other)
      # if self.class != other.class
      #   fail "#{self.class} and #{other.class} are not equal Objects"
      # end

      self.class.diffable_fields.map do |field|
        Diffable::Attribute.new(field, self, other)
      end.select(&:comparable?)
    end

    def diff_value_for(field, obj = self)
      if field.is_a?(Symbol)
        return obj.send(field) if obj.respond_to?(field)
        return obj[field] if obj.respond_to?(:[]) and !obj.is_a?(Array)
        return
      end

      if field.is_a?(Array)
        key   = field[0]
        rest  = field[1..-1]
        value = diff_value_for(key, obj)
        rest.each do |sub_field|
          value = diff_value_for(sub_field, value)
        end

        return value if value
      end
    end
  end
end
