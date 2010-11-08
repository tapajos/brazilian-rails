# encoding: UTF-8
require File.dirname(__FILE__) +  "/test_helper"

class NilClassTest < ActiveSupport::TestCase
  
  test "Real" do
    assert_equal Dinheiro.new(0), nil.real
  end
  
  test "Reais" do
    assert_equal Dinheiro.new(0), nil.reais
  end
  
  test "para dinheiro" do
    assert_equal Dinheiro.new(0), nil.para_dinheiro
  end
  
  test "valor" do
    assert_equal Dinheiro.new(0), nil.valor
  end
  
  test "contabil" do
    assert_equal "0,00", nil.contabil
  end
 
end
