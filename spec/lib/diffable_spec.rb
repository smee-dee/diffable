require 'spec_helper'

describe Diffable do
  it 'extends any Object with Diffable::ClassMethods' do
    expect(Dummy).to respond_to(:diffable?)
  end

  it 'extends any Object instance with Diffable::InstanceMethods' do
    expect(Dummy.new).to respond_to(:diff)
  end
end
