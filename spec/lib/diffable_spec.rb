require 'spec_helper'

describe Diffable do
  it 'extends ActiveRecord with Diffable::ClassMethods' do
    expect(Dummy).to respond_to(:diffable?)
  end
end
