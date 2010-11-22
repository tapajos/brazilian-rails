require "bigdecimal"
require "rubygems"
require "active_record"
require "active_support/all"
require "brdinheiro/excecoes"
require "brdinheiro/nil_class"
require "brdinheiro/dinheiro" 
require "brdinheiro/dinheiro_util" 

module BrDinheiro
  if defined?(ActiveRecord)
    require File.dirname(__FILE__) + "/brdinheiro/dinheiro_active_record" 
    ActiveRecord::Base.send :include, DinheiroActiveRecord
  end
end

