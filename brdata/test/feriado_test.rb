# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'

class FeriadoTest < Test::Unit::TestCase
  
  ATRIBUTOS = %w(dia mes nome)
  
  # feriado 
  def test_feriado_quando_feriado
    assert "25/12/2007".to_date.feriado?
  end
  
  def test_feriado_quando_nao_eh_feriado
    assert !"01/12/2007".to_date.feriado?
  end
  
  def test_feriado_quando_feriado_eh_pascoa
    assert "08/04/2007".to_date.feriado?
  end
  
  def test_feriado_quando_feriado_eh_corpus_christi
    assert "07/06/2007".to_date.feriado?
  end
  
  # pascoa
  def test_pascoa
    assert_equal "08/04/2007", "01/01/2007".to_date.pascoa.to_s_br
  end
  
  # corpus_christi
  def test_corpus_christi
    assert_equal "07/06/2007", "01/01/2007".to_date.corpus_christi.to_s_br
  end
  
  
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
    ['a', 0, -1, 32, '32', '-1', '0'].each do |invalid_day|
      assert_raise FeriadoDiaInvalidoError do
        Feriado.new("nome", invalid_day, "01")
        raise "Deveria retornar FeriadoDiaInvalidoError para dia #{invalid_day}"
      end
    end
  end
  
  def test_initialize_com_mes_invalido
    ['a', '13', 13, -1, '-1', '0'].each do |invalid_month| 
      assert_raise FeriadoMesInvalidoError do
        Feriado.new("nome", "01", invalid_month)  
        raise "Deveria retornar FeriadoMesInvalidoError para mês #{invalid_month}"
      end
    end
  end
  
  def test_igualdade
    assert_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "01")
  end
  
  def test_igualdade_quando_nao_eh_igual
    assert_not_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "02")
  end

end
