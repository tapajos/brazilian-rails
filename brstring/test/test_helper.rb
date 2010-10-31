ENV["RAILS_ENV"] = "test"

require 'test/unit'
require 'rubygems'
require "rails"
require 'rails/test_help'

require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brstring.rb")
