ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require 'rails/test_help'
require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brdinheiro.rb")

def tornar_metodos_publicos(clazz)
  clazz.class_eval do
    private_instance_methods.each { |instance_method| public instance_method }
    private_methods.each { |method| public_class_method method }
  end
end
