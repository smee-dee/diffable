require 'spec_helper'

describe Diffable::Output do
  let(:dummy1) { DummyWithAttributes.new('dummy 1') }
  let(:dummy2) { DummyWithAttributes.new('dummy 2') }
  let(:output) { dummy1.diff dummy2 }

  let(:assoc_dummy1) { DummyWithAssociation.new('assoc dummy 1') }
  let(:assoc_dummy2) { DummyWithAssociation.new('assoc dummy 2') }
  let(:assoc_output) { assoc_dummy1.diff assoc_dummy2 }

  let(:result_fieldname) { 'dummy_with_attributes.name' }

  describe '#to_s' do
    it 'returns plain diff' do
      expect_diffy_format(:text, 'plain_diff')
      expect(output.to_s).to eq "#{result_fieldname}:\nplain_diff"
    end
  end

  describe '#to_ansi_color' do
    it 'returns ansi colored diff' do
      expect_diffy_format(:color, 'color_diff')
      expect(output.to_ansi_color).to eq "#{result_fieldname}:\ncolor_diff"
    end
  end

  describe '#to_html' do
    it 'returns html formatted diff' do
      expect_diffy_format(:html, 'html_diff')
      html = "<div class=\"diffable-diff html\">" +
             "<div class=\"field\">#{result_fieldname}:</div>html_diff</div>"
      expect(output.to_html).to eq html
    end
  end

  describe '#to_simple_html' do
    it 'returns simple html formatted diff' do
      expect_diffy_format(:html_simple, 'html_simple_diff')
      html = "<div class=\"diffable-diff simple-html\">" +
             "<div class=\"field\">#{result_fieldname}:</div>" +
             "html_simple_diff</div>"
      expect(output.to_simple_html).to eq html
    end
  end

  context 'with associated objects' do
    it '#diff returns the diff of the associated objects' do
      expect_diffy_format(:text, 'text_diff')
      expect(assoc_output.to_s)
        .to eq "dummy_with_association.associated_objects=>" +
               "associated_dummy.value:\ntext_diff"
    end
  end

  def expect_diffy_format(format, val)
    ::Diffy::Diff.any_instance
                 .should_receive(:to_s)
                 .with(format)
                 .and_return(val)
  end
end
