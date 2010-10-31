# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class FeriadoTest < ActiveSupport::TestCase

  ATRIBUTOS = %w(dia mes nome)

  # feriado

  test "Feriado quando é feriado" do
    assert "25/12/2007".to_date.feriado?
  end

  test "Feriado quando não é feriado" do
    assert !"01/12/2007".to_date.feriado?
  end

  test "Feriado quando é pascoa" do
    assert "08/04/2007".to_date.feriado?
  end

  test "Feriado quando é corpus christi" do
    assert "07/06/2007".to_date.feriado?
  end

  # pascoa
  test "Páscoa" do
    assert_equal "08/04/2007", "01/01/2007".to_date.pascoa.to_s_br
  end

  # corpus_christi
  test "Corpus Christi" do
    assert_equal "07/06/2007", "01/01/2007".to_date.corpus_christi.to_s_br
  end


  test "Attributes" do
    feriado = Feriado.new("nome", "01", "01")
    ATRIBUTOS.each do |atributo|
      assert_respond_to feriado, "#{atributo}", "Deveria existir o método #{atributo}"
      assert_respond_to feriado, "#{atributo}=", "Deveria existir o método #{atributo}="
    end
  end

  test "Initialize" do
    feriado = Feriado.new("nome", "01", "01")
    assert feriado, "deveria ter criado um feriado"
    assert_equal "nome", feriado.nome
    assert_equal 1, feriado.dia
    assert_equal 1, feriado.mes
  end

  test "Feriado initialize com dia inválido" do
    ['a', 0, -1, 32, '32', '-1', '0'].each do |invalid_day|
      assert_raise FeriadoDiaInvalidoError do
        Feriado.new("nome", invalid_day, "01")
        raise "Deveria retornar FeriadoDiaInvalidoError para dia #{invalid_day}"
      end
    end
  end

  test "Feriado initialize com mes inválido" do
    ['a', '13', 13, -1, '-1', '0'].each do |invalid_month|
      assert_raise FeriadoMesInvalidoError do
        Feriado.new("nome", "01", invalid_month)
        raise "Deveria retornar FeriadoMesInvalidoError para mês #{invalid_month}"
      end
    end
  end

  test "Igualdade" do
    assert_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "01")
  end

  test "Igualdade quando não é igual" do
    assert_not_equal Feriado.new("nome", "01", "01"), Feriado.new("nome2", "01", "02")
  end

end

