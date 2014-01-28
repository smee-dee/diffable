require 'pry'
require 'simplecov'
require 'rubygems'
require 'bundler/setup'
require 'diffable'

SimpleCov.start

Dir[File.expand_path('spec/factories/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
