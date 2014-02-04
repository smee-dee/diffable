module Diffable
  class AttributeExtractor < Struct.new(:field, :object1, :object2)
    def attributes
      if field.is_a?(Array) and field.first == :many
        ManyAttributesExtractor.new(field, object1, object2).attributes
      else
        [Diffable::Attribute.new(field, object1, object2)]
      end
    end
  end
end
