ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require 'rails/test_help'

require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brI18n.rb")
require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/generators/br_i18n/locales_generator.rb")
