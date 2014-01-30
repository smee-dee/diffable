require 'pry'
require 'json'
require 'simplecov'
require 'rubygems'
require 'bundler/setup'

SimpleCov.start

require 'diffable'
Dir[File.expand_path('spec/factories/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
