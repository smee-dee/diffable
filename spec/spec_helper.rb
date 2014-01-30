require 'pry'
require 'json'
require 'simplecov'
require 'rubygems'
require 'bundler/setup'

SimpleCov.start

Dir['lib/**/*.rb'].each { |file| load(file); }
Dir[File.expand_path('spec/factories/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
