module Diffable
  class Output
    attr_reader :diff_attributes

    def initialize(diff_attributes)
      @diff_attributes = diff_attributes
    end

    def to_s
      output = ''
      each_diff_as(:text) do |attr, diff|
        output << "#{attr.translated_fieldname}:\n" + diff
      end

      output
    end

    def to_ansi_color
      output = ''
      each_diff_as(:color) do |attr, diff|
        output << "#{attr.translated_fieldname}:\n" + diff
      end

      output
    end

    def to_html
      output = '<div class="diffable-diff html">'
      each_diff_as(:html) do |attr, diff|
        output << "<div class=\"field\">#{attr.translated_fieldname}:</div>"
        output << diff
      end

      output << '</div>'
    end

    def to_simple_html
      output = '<div class="diffable-diff simple-html">'
      each_diff_as(:html_simple) do |attr, diff|
        output << "<div class=\"field\">#{attr.translated_fieldname}:</div>"
        output << diff
      end

      output << '</div>'
    end

    def each_diff_as(format)
      @diff_attributes.each do |attr|
        yield(attr, attr.diff(format))
      end
    end
  end
end
