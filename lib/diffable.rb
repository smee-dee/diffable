require 'diffy'
require 'diffable/version'
require 'diffable/class_methods'
require 'diffable/instance_methods'
require 'diffable/attribute'
require 'diffable/attribute_extractor'
require 'diffable/associated_attribute_extractor'
require 'diffable/output'

Object.send(:extend, Diffable::ClassMethods)
Object.send(:include, Diffable::InstanceMethods)
