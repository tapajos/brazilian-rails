require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/active_record/base_without_table'

class Carteira < ActiveRecord::BaseWithoutTable
  column :saldo, :decimal
  usar_como_dinheiro :saldo
end
 
class DinheiroActiveRecordTest < Test::Unit::TestCase
   
  def setup
    @carteira = Carteira.new
  end
   
  def teste_se_aceita_dinheiro
    @carteira.saldo = 8.reais
    assert @carteira.save
    assert_equal 8.reais, @carteira.saldo
  end
 
  def teste_se_aceita_numero
    @carteira.saldo = 30
    assert @carteira.save
    assert_equal 30.reais, @carteira.saldo
  end
   
  def teste_se_rejeita_valor_invalido
    @carteira.saldo = 30
    assert @carteira.save
    @carteira.saldo = 'bla'
    assert_false @carteira.save
    assert_equal "O valor deve estar preenchido e no formato correto. Ex.: 100.00 .", @carteira.errors['saldo']
  end
   
  def teste_se_trata_nulo_corretamente
    assert_nil @carteira.saldo
    @carteira.saldo = nil
    assert_nil @carteira.saldo
    @carteira.save
    assert_nil @carteira.saldo
  end
 
  def test_se_cria_carteira_corretamente_quando_recebe_parametros
    carteira = Carteira.new(:saldo => "1")
    assert_equal 1.real, carteira.saldo
  end
 
end
