require 'spec_helper'

describe Diffable::ClassMethods do
  subject { Dummy }

  describe '.diffable?' do
    it { should respond_to(:diffable?) }

    it 'is false if no diffable fields are defined' do
      subject.stub(:diffable_fields).and_return(nil)
      expect(subject.diffable?).to be_false
    end

    it 'is true if diffable fields are defined' do
      subject.stub(:diffable_fields).and_return([:field])
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
      # subject.should_receive(:save_fields_as_array).with([:f1, :f2])
      subject.diffable_on(:f1, :f2)
      expect(subject.diffable_fields).to eq [:f1, :f2]
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
