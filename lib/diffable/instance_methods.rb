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

      fields = []
      self.class.diffable_fields.each do |field|
        if field.is_a?(Array) and field.first == :many
          associated = field.drop(1)
          associated = [associated] unless associated.is_a?(Array)
          associated.each do |assoc|
            send(assoc).zip(other.send(assoc)).each do |assoc_obj|
              assoc_obj.first.diff_fields(assoc_obj.last).each do |diffable_attribute|
                fields << diffable_attribute
              end
            end
          end
        else
          fields << Diffable::Attribute.new(field, self, other)
        end
      end

      fields
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
