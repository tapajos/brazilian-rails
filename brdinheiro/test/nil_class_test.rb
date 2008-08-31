require File.dirname(__FILE__) + '/test_helper'

class NilClassTest < Test::Unit::TestCase
  
  def test_real
    assert_equal Dinheiro.new(0), nil.real
  end
  
  def test_reais
    assert_equal Dinheiro.new(0), nil.reais
  end
  
  def test_para_dinheiro
    assert_equal Dinheiro.new(0), nil.para_dinheiro
  end
  
  def test_valor
    assert_equal Dinheiro.new(0), nil.valor
  end
  
  def test_contabil
    assert_equal "0,00", nil.contabil
  end
  
  
  
  
  
end
