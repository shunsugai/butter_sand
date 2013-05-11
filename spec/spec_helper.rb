require 'simplecov'

SimpleCov.start do
  add_filter 'spec'
end

require 'bundler/setup'
require 'butter_sand'
require 'faraday/response/raise_butter_sand_error'
require 'webmock/rspec'
require 'date'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.order = 'random'
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
