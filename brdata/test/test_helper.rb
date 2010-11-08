ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require "rails/generators"
require 'rails/test_help'
require 'active_support/all'
require 'mocha'

require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brdata.rb")
require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/generators/br_data/install/install_generator.rb")
