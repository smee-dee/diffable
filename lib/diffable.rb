require 'diffy'
require 'diffable/version'
require 'diffable/class_methods'
require 'diffable/instance_methods'
require 'diffable/attribute'
require 'diffable/output'

Object.send(:extend, Diffable::ClassMethods)
Object.send(:include, Diffable::InstanceMethods)
