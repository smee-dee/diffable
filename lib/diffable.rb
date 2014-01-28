require 'active_support'
require 'active_record'
require 'diffable/version'
require 'diffable/class_methods'

module Diffable
end

ActiveSupport.on_load(:active_record) do
  extend Diffable::ClassMethods
end
