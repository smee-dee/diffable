require 'diffable/version'
require 'diffable/class_methods'
require 'diffable/instance_methods'
require 'diffable/attribute'

Object.send(:extend, Diffable::ClassMethods)
Object.send(:include, Diffable::InstanceMethods)
