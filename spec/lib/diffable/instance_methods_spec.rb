require 'spec_helper'

describe Diffable::InstanceMethods do
  let(:subject1) { DummyWithAttributes.new('dummy 1') }
  let(:subject2) { DummyWithAttributes.new('dummy 2') }

  describe '#diff_fields' do
    context 'given only one attribute that is different' do
      it 'returns an array containing one Diffable::Attribute for it' do
        value = subject1.diff_fields(subject2)
        expect(value).to be_an_instance_of(Array)
        expect(value.size).to be 1
        expect(value.first).to be_an_instance_of Diffable::Attribute
        expect(value.first.field).to eq :name
      end
    end

    context 'given multiple attributes that are different' do
      before do
        subject1.settings = {sub1: 's1', sub2: 's2'}
        subject2.settings = {sub1: 's1', sub2: 'x2'}
      end

      context '2 different fields' do
        it 'returns an array containing 2 Attributes' do
          value = subject1.diff_fields(subject2)
          expect(value).to be_an_instance_of(Array)
          expect(value.size).to be 2
          expect(value.first.field).to eq :name
          expect(value.last.field).to eq [:settings, :sub2]
        end
      end

      context '3 differenct fields' do
        before { subject2.settings[:sub1] = 'x1' }

        it 'returns an array containing 3 Attributes' do
          value = subject1.diff_fields(subject2)
          expect(value).to be_an_instance_of(Array)
          expect(value.size).to be 3
          expect(value.first.field).to eq :name
          expect(value[1].field).to eq [:settings, :sub1]
          expect(value.last.field).to eq [:settings, :sub2]
        end
      end
    end
  end
end
