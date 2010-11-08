ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require "rails/generators"
require 'rails/test_help'
require 'active_support/all'
require 'mocha'

require "brdata"
require "generators/br_data/install/install_generator"
