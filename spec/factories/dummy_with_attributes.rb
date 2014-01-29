class DummyWithAttributes
  attr_accessor :name, :settings

  diffable_on :name, settings: [:sub1, :sub2]

  def initialize(name = 'Name', settings = nil)
    @name     = name
    @settings = settings
  end
end
