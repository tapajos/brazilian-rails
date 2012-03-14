$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

$KCODE = 'utf-8' if RUBY_VERSION < '1.9'

require 'rubygems'
require 'active_support'
require 'active_support/core_ext'

%w(version
string_portuguese).each {|req| require File.dirname(__FILE__) + "/brstring/#{req}"}

module BrString
end
