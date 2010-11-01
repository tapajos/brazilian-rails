%w(excecoes nil_class).each {|req| require File.dirname(__FILE__) + "/brdinheiro/#{req}"}

%w(bigdecimal
rubygems
active_record
active_support/all).each {|req| require req }

module BrDinheiro
  def self.setup
    yield self 
  end

  private
  def self.ativar_dinheiro
    require File.dirname(__FILE__) + "/brdinheiro/dinheiro.rb" 
    require File.dirname(__FILE__) + "/brdinheiro/dinheiro_util.rb" 
  end

  def self.ativar_activerecord_metodos
    require File.dirname(__FILE__) + "/brdinheiro/dinheiro_active_record.rb" 
    ActiveRecord::Base.send :include, DinheiroActiveRecord
  end
end

