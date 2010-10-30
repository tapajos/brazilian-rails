ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require 'rails/test_help'
require 'net/http'
require 'mocha'
include ActionView::Helpers::FormOptionsHelper
include ActionView::Helpers::FormHelper

require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brhelper.rb")
