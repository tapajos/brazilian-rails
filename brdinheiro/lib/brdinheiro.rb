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
active_support).each {|req| require req }

begin
  require 'brnumeros'
rescue MissingSourceFile
  # probably not installed yet as a gem, so load from source
  begin
    require File.dirname(__FILE__) + '/../../brnumeros/lib/brnumeros'
  rescue
  end
end

String.send(:include, DinheiroUtil)
ActiveRecord::Base.send :include, DinheiroActiveRecord

module BrDinheiro  
end
