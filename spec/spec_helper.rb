ENV['RACK_ENV'] = 'test'

require 'rack/test'
# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test

# Require test libraries
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'mocha/setup'
require 'capybara'
require 'capybara/dsl'
require 'capybara/json'
require 'minitest/reporters'
require 'benchmark'
require 'sinatra'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new, Minitest::Reporters::SpecReporter.new]

require_relative '../sinatra_play'

#Dir.glob('./apis/**/*.rb').each { |file| require file }

include Rack::Test::Methods
OUTER_APP = Rack::Builder.parse_file('config.ru').first

def app
  #Sinatra::Application
  OUTER_APP
end

# class MiniTest::Spec
#   include Capybara::DSL
#   include Capybara::Json
# end

# Capybara.current_driver = :rack_test_json

