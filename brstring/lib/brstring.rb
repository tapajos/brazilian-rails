$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
$KCODE = 'utf-8'

require 'rubygems'  
require 'activesupport'
  
%w(version
string_portuguese).each {|req| require File.dirname(__FILE__) + "/brstring/#{req}"}

module BrString
end