require 'spec_helper'

describe Diffable do
  it 'extends any Object with Diffable::ClassMethods' do
    expect(Dummy).to respond_to(:diffable?)
  end
end
