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

  describe '.diffable_fields' do
    it { should respond_to(:diffable_fields) }

    it 'is nil if no fields given' do
      expect(subject.diffable_fields).to be_nil
    end

    it 'returns an array with field1 if one field is given' do
      subject.instance_variable_set(:@diffable_fields, [:field1])
      expect(subject.diffable_fields).to eq [:field1]
    end

    it 'returns an array with field1, field1 if given' do
      subject.instance_variable_set(:@diffable_fields, [:field1, :field2])
      expect(subject.diffable_fields).to eq [:field1, :field2]
    end
  end

  describe '.diffable_on' do
    it { should respond_to(:diffable_on) }

    it 'raises an error if not .valid_fields?' do
      subject.stub(:valid_fields?).and_return(false)
      expect { subject.diffable_on }.to raise_error
    end

    it 'assigns the parsed diffable fields if given' do
      subject.stub(:valid_fields?).and_return(true)
      subject.should_receive(:save_fields_as_array).with([:f1, :f2])
      subject.diffable_on(:f1, :f2)
    end
  end

  describe '.valid_fields?' do
    it 'is true if array is given' do
      expect(subject.valid_fields?([:f1, :f2])).to be_true
    end

    it 'is true if only one symbol is given' do
      expect(subject.valid_fields?(:f1)).to be_true
    end

    it 'is true if a string is given' do
      expect(subject.valid_fields?('f1')).to be_true
    end

    it 'is true if a Hash is given' do
      expect(subject.valid_fields?(f1: :f2)).to be_true
    end

    it 'is false if no array, symbol or string is given' do
      expect(subject.valid_fields?(666)).to be_false
      expect(subject.valid_fields?(true)).to be_false
    end
  end
end
