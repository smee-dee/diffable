module Diffable
  class AssociatedAttributeExtractor < AttributeExtractor
    def attributes
      attributes = []
      associations.each do |association|
        each_associated_diff_attribute_for(association) do |attribute|
          attribute.add_superior object1.class.name
          attribute.add_superior association
          attributes << attribute
        end
      end

      attributes
    end

    private

    def associations
      associations = field.drop(1)
      associations = [associations] unless associations.is_a?(Array)
      associations
    end

    def each_associated_diff_attribute_for(association)
      zipped(association).each do |assoc_obj|
        assoc_obj.first.diff_fields(assoc_obj.last).each do |attribute|
          yield attribute
        end
      end
    end

    def zipped(association)
      object1.send(association).zip(object2.send(association))
    end
  end
end
