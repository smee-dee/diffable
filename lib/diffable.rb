require 'active_support'
require 'active_record'
require 'diffable/version'
require 'diffable/class_methods'

ActiveSupport.on_load(:active_record) do
  extend Diffable::ClassMethods
end
