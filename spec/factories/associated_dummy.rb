class AssociatedDummy < Struct.new(:value)
  attr_reader :value

  diffable_on :value
end
