require "bigdecimal"
require "rubygems"
require "active_record"
require "active_support/all"
require "brdinheiro/excecoes"
require "brdinheiro/nil_class"
require "brdinheiro/dinheiro" 
require "brdinheiro/dinheiro_util" 

module BrDinheiro
  def self.setup
    yield self 
  end

  private
  def self.ativar_activerecord_metodos
    require File.dirname(__FILE__) + "/brdinheiro/dinheiro_active_record" 
    ActiveRecord::Base.send :include, DinheiroActiveRecord
  end
end

