module Diffable
  module InstanceMethods
    def diff(other)
      Diffable::Output.new comparable_diff_fields(other)
    end

    def comparable_diff_fields(other)
      diff_fields(other).select(&:comparable?)
    end

    def diff_fields(other)
      if self.class != other.class
        fail "#{self.class} and #{other.class} are not equal Objects"
      end

      self.class.diffable_fields.map do |field|
        Diffable::AttributeExtractor.new(field, self, other).attributes
      end.flatten
    end

    def diff_value_for(field, obj = self)
      if field.is_a?(Symbol)
        return obj.send(field) if obj.respond_to?(field) and obj.send(field)
        return obj[field] if obj.respond_to?(:[]) and !obj.is_a?(Array)
        return
      end

      if field.is_a?(Array)
        value = diff_value_for(field[0], obj)
        field[1..-1].each { |_sub| value = diff_value_for(_sub, value) }

        return value
      end
    end
  end
end
