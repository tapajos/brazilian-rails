#$: << File.dirname(__FILE__) + '/..' << File.dirname(__FILE__) + '/../lib'
#%w(test/unit rubygems init mocha).each { |lib| require lib }
require File.dirname(__FILE__) + '/test_helper'

class FeriadoTest < Test::Unit::TestCase
  
  ATRIBUTOS = %w(dia mes nome)
  
  def test_attributes
    feriado = Feriado.new("nome", "01", "01")
    ATRIBUTOS.each do |atributo|
      assert_respond_to feriado, "#{atributo}", "Deveria existir o método #{atributo}"
      assert_respond_to feriado, "#{atributo}=", "Deveria existir o método #{atributo}="
    end
  end
  
  def test_initialize
    feriado = Feriado.new("nome", "01", "01")
    assert feriado, "deveria ter criado um feriado"
    assert_equal "nome", feriado.nome
    assert_equal 1, feriado.dia
    assert_equal 1, feriado.mes
  end
  
  def test_initialize_com_dia_invalido
    assert_raise FeriadoDiaInvalidoError do
      Feriado.new("nome", "a", "01")  
    end
    assert_raise FeriadoDiaInvalidoError do
      Feriado.new("nome", "32", "01")  
    end
  end
  
  def test_initialize_com_mes_invalido
    assert_raise FeriadoMesInvalidoError do
      Feriado.new("nome", "01", "a")  
    end
    assert_raise FeriadoMesInvalidoError do
      Feriado.new("nome", "01", "13")  
    end
  end
  
  def test_igualdade
    assert_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "01")
  end
  
  def test_igualdade_quando_nao_eh_igual
    assert_not_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "02")
  end

end
