$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(number_portuguese version).each {|req| require File.dirname(__FILE__) + "/brnumeros/#{req}"}

module BrNumeros
end