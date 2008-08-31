$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
%w(dinheiro
dinheiro_util
dinheiro_active_record
excecoes
nil_class).each {|req| require File.dirname(__FILE__) + "/brdinheiro/#{req}"}

%w(bigdecimal
rubygems
active_record
activesupport
brnumeros).each {|req| require req }

String.send(:include, DinheiroUtil)
ActiveRecord::Base.send :include, DinheiroActiveRecord

module BrDinheiro  
end