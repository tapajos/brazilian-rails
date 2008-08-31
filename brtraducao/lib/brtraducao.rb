$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'  
require 'action_controller'
require 'html/document'
require 'active_support'
require 'action_view'
# require 'action_pack'
  
%w(action_view_portuguese
version
active_record_portuguese).each {|req| require File.dirname(__FILE__) + "/brtraducao/#{req}"}


module BrTraducao
end