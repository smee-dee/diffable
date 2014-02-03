require 'spec_helper'

describe Diffable::ClassMethods do
  subject { Dummy }

  before do
    Object.send(:remove_const, 'Dummy')
    load 'spec/factories/dummy.rb'
  end

  describe '.diffable?' do
    it { should respond_to(:diffable?) }

    it 'is false if no diffable fields are defined' do
      subject.class_eval { @diffable_fields = nil }
      expect(subject.diffable?).to be_false
    end

    it 'is true if diffable fields are defined' do
      subject.class_eval { @diffable_fields = [:f1] }
      expect(subject.diffable?).to be_true
    end
  end

  describe '.diffable_on' do
    it { should respond_to(:diffable_on) }

    it 'raises an error if not .valid_fields?' do
      subject.stub(:valid_fields?).and_return(false)
      expect { subject.diffable_on }.to raise_error
    end

    it 'raises an error if nothing is provided' do
      expect { subject.diffable_on }.to raise_error
    end

    it 'assigns the parsed diffable fields if given' do
      subject.stub(:valid_fields?).and_return(true)
      expect { subject.diffable_on(:f1, :f2) }.not_to raise_error
    end
  end

  describe '.diffable_fields' do
    let(:input) do
      [
        :f1,
        f2: [
          :sub1,
          :sub2,
          sub3: [
            subsub1: :subsubsub1
          ]
        ]
      ]
    end
    let(:output) do
      [
        :f1,
        [:f2, :sub1],
        [:f2, :sub2],
        [:f2, :sub3, :subsub1, :subsubsub1]
      ]
    end

    it 'returns each attr accessing "path"' do
      subject.diffable_on(input)
      expect(subject.diffable_fields).to eq output
    end
  end

  describe '.valid_fields?' do
    it 'is true if parameter is in valid types' do
      expect(subject.valid_fields?([:f1])).to be_true
    end

    it 'is false if parameter is not in valid types' do
      expect(subject.valid_fields?([1])).to be_false
    end
  end

  describe '.valid_parameter_types' do
    it 'is an array with Array, Symbol, String, Hash' do
      [Symbol, String, Hash].each do |type|
        expect(subject.valid_parameter_types).to include(type)
      end
    end
  end
end
