class DummyWithAssociation
  attr_reader :associated_objects

  diffable_on many: :associated_objects

  def initialize(associated_value)
    @associated_objects = [AssociatedDummy.new(associated_value)]
  end
end
