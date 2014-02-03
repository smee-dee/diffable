require 'spec_helper'

describe Diffable::Output do
  let(:dummy1) { DummyWithAttributes.new('dummy 1') }
  let(:dummy2) { DummyWithAttributes.new('dummy 2') }
  let(:output) { dummy1.diff dummy2 }

  describe '#to_s' do
    it 'returns plain diff' do
      expect_diffy_format(:text, 'plain_diff')
      expect(output.to_s).to eq "name:\nplain_diff"
    end
  end

  describe '#to_ansi_color' do
    it 'returns ansi colored diff' do
      expect_diffy_format(:color, 'color_diff')
      expect(output.to_ansi_color).to eq "name:\ncolor_diff"
    end
  end

  describe '#to_html' do
    it 'returns html formatted diff' do
      expect_diffy_format(:html, 'html_diff')
      html = "<div class=\"diffable-diff html\">" +
             "<div class=\"field\">name:</div>html_diff</div>"
      expect(output.to_html).to eq html
    end
  end

  describe '#to_simple_html' do
    it 'returns simple html formatted diff' do
      expect_diffy_format(:html_simple, 'html_simple_diff')
      html = "<div class=\"diffable-diff simple-html\">" +
             "<div class=\"field\">name:</div>html_simple_diff</div>"
      expect(output.to_simple_html).to eq html
    end
  end

  def expect_diffy_format(format, val)
    ::Diffy::Diff.any_instance
                 .should_receive(:to_s)
                 .with(format)
                 .and_return(val)
  end
end
