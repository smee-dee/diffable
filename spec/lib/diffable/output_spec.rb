require 'spec_helper'

describe Diffable::Output do
  let(:dummy1) { DummyWithAttributes.new('dummy 1') }
  let(:dummy2) { DummyWithAttributes.new('dummy 2') }
  let(:output) { dummy1.diff dummy2 }

  describe '#to_s' do
    it 'returns plain diff' do
      plain = "name:\n-dummy 1\n\\ " +
              "No newline at end of file\n+dummy 2\n\\ " +
              "No newline at end of file\n"
      expect(output.to_s).to eq plain
    end
  end

  describe '#to_ansi_color' do
    it 'returns ansi colored diff' do
      color = "name:\n\e[31m-dummy 1\e[0m\n\\ " +
              "No newline at end of file\n\e[32m+dummy 2\e[0m\n\\ " +
              "No newline at end of file\n"
      expect(output.to_ansi_color).to eq color
    end
  end

  describe '#to_html' do
    it 'returns html formatted diff' do
      html = "<div class=\"diffable-diff html\">" +
             "<div class=\"field\">name:</div>" +
             "<div class=\"diff\">\n  " +
             "<ul>\n    " +
             "<li class=\"del\"><del>dummy <strong>1</strong></del></li>\n" +
             "    <li class=\"ins\"><ins>dummy <strong>2</strong></ins></li>" +
             "\n  </ul>\n</div>\n</div>"
      expect(output.to_html).to eq html
    end
  end

  describe '#to_simple_html' do
    it 'returns simple html formatted diff' do
      html = "<div class=\"diffable-diff simple-html\">" +
             "<div class=\"field\">name:</div><div class=\"diff\">\n" +
             "  <ul>\n    <li class=\"del\"><del>dummy 1</del></li>\n\n" +
             "    <li class=\"ins\"><ins>dummy 2</ins></li>\n\n  " +
             "</ul>\n</div>\n</div>"
      expect(output.to_simple_html).to eq html
    end
  end
end
