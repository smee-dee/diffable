module Diffable
  class Attribute
    attr_reader :field, :object1, :object2, :superiors

    def initialize(field, object1, object2)
      @field, @object1, @object2 = field, object1, object2
      @superiors = []
    end

    def comparable?
      value1 and value2 and value1 != value2
    end

    def value1
      value_for(object1)
    end

    def value2
      value_for(object2)
    end

    def fieldname
      [object1.class.name, field].flatten.join '.'
    end

    def superiors_name
      superiors.each_slice(2).map { |pair| pair.join '.' }
    end

    def full_fieldname
      [superiors_name, fieldname].reject(&:empty?).join('=>')
    end

    def translated_fieldname
      result = to_snake_case full_fieldname
      defined?(I18n) ? I18n.t(result) : result
    end

    def diff(format = :html)
      ::Diffy::Diff.new(value1, value2).to_s(format)
    end

    def add_superior(superior)
      @superiors << superior
    end

    private

    def to_snake_case(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
    end

    def value_for(object)
      value = object.diff_value_for(field)
      value if value and value.is_a?(String)
    end
  end
end
