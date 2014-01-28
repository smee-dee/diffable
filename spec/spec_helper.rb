require 'pry'
require 'simplecov'
require 'rubygems'
require 'bundler/setup'
require 'diffable'

SimpleCov.start

Dir[File.expand_path('spec/factories/*.rb')].each { |f| require f }

database_yml = File.expand_path('../database.yml', __FILE__)
active_record_configuration = YAML.load_file(database_yml)
ActiveRecord::Base.configurations = active_record_configuration

ActiveRecord::Base.establish_connection 'test'
ActiveRecord::Base.connection

load(File.dirname(__FILE__) + '/schema.rb')

RSpec.configure do |config|
end
