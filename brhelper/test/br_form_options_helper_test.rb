# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'net/http'
require 'mocha'

class BrFormOptionsHelperTest < Test::Unit::TestCase
  
  include ActionView::Helpers::FormOptionsHelper
  
  def test_option_estados_for_select
    assert_equal %(<option value=\"AC\">Acre</option>\n<option value=\"AL\">Alagoas</option>\n<option value=\"AP\">Amapá</option>\n<option value=\"AM\">Amazonas</option>\n<option value=\"BA\">Bahia</option>\n<option value=\"CE\">Ceará</option>\n<option value=\"DF\">Distrito Federal</option>\n<option value=\"ES\">Espírito Santos</option>\n<option value=\"GO\">Goiás</option>\n<option value=\"MA\">Maranhão</option>\n<option value=\"MT\">Mato Grosso</option>\n<option value=\"MS\">Mato Grosso do Sul</option>\n<option value=\"MG\">Minas Gerais</option>\n<option value=\"PA\">Pará</option>\n<option value=\"PB\">Paraíba</option>\n<option value=\"PR\">Paraná</option>\n<option value=\"PE\">Pernambuco</option>\n<option value=\"PI\">Piauí</option>\n<option value=\"RJ\">Rio de Janeiro</option>\n<option value=\"RN\">Rio Grande do Norte</option>\n<option value=\"RS\">Rio Grande do Sul</option>\n<option value=\"RO\">Rondônia</option>\n<option value=\"RR\">Roraima</option>\n<option value=\"SC\">Santa Catarina</option>\n<option value=\"SP\">São Paulo</option>\n<option value=\"SE\">Sergipe</option>\n<option value=\"TO\">Tocantins</option>), option_estados_for_select
  end
  
  def test_option_uf_for_select
    assert_equal %(<option value=\"AC\">AC</option>\n<option value=\"AL\">AL</option>\n<option value=\"AP\">AP</option>\n<option value=\"AM\">AM</option>\n<option value=\"BA\">BA</option>\n<option value=\"CE\">CE</option>\n<option value=\"DF\">DF</option>\n<option value=\"ES\">ES</option>\n<option value=\"GO\">GO</option>\n<option value=\"MA\">MA</option>\n<option value=\"MT\">MT</option>\n<option value=\"MS\">MS</option>\n<option value=\"MG\">MG</option>\n<option value=\"PA\">PA</option>\n<option value=\"PB\">PB</option>\n<option value=\"PR\">PR</option>\n<option value=\"PE\">PE</option>\n<option value=\"PI\">PI</option>\n<option value=\"RJ\">RJ</option>\n<option value=\"RN\">RN</option>\n<option value=\"RS\">RS</option>\n<option value=\"RO\">RO</option>\n<option value=\"RR\">RR</option>\n<option value=\"SC\">SC</option>\n<option value=\"SP\">SP</option>\n<option value=\"SE\">SE</option>\n<option value=\"TO\">TO</option>), option_uf_for_select
  end
  
  def test_select_estado
    assert_equal %(<select id=\"lancamento_estado\" name=\"lancamento[estado]\"><option value=\"AC\">Acre</option>\n<option value=\"AL\">Alagoas</option>\n<option value=\"AP\">Amapá</option>\n<option value=\"AM\">Amazonas</option>\n<option value=\"BA\">Bahia</option>\n<option value=\"CE\">Ceará</option>\n<option value=\"DF\">Distrito Federal</option>\n<option value=\"ES\">Espírito Santos</option>\n<option value=\"GO\">Goiás</option>\n<option value=\"MA\">Maranhão</option>\n<option value=\"MT\">Mato Grosso</option>\n<option value=\"MS\">Mato Grosso do Sul</option>\n<option value=\"MG\">Minas Gerais</option>\n<option value=\"PA\">Pará</option>\n<option value=\"PB\">Paraíba</option>\n<option value=\"PR\">Paraná</option>\n<option value=\"PE\">Pernambuco</option>\n<option value=\"PI\">Piauí</option>\n<option value=\"RJ\">Rio de Janeiro</option>\n<option value=\"RN\">Rio Grande do Norte</option>\n<option value=\"RS\">Rio Grande do Sul</option>\n<option value=\"RO\">Rondônia</option>\n<option value=\"RR\">Roraima</option>\n<option value=\"SC\">Santa Catarina</option>\n<option value=\"SP\">São Paulo</option>\n<option value=\"SE\">Sergipe</option>\n<option value=\"TO\">Tocantins</option></select>), select_estado(:lancamento, :estado)
  end
  
  def test_select_uf
    options = {:options1 => "1"}
    html_options = {:name => "name"}
    expects(:select).with(:lancamento, :estado, ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'], {:options1 => '1'}, {:name => 'name'}).returns("select")
    assert_equal "select", select_uf(:lancamento, :estado, options, html_options)
  end

  def test_select_sexo
    assert_equal %(<select id="lancamento_sexo" name="lancamento[sexo]"><option value="M">Masculino</option>\n<option value="F">Feminino</option></select>), select_sexo(:lancamento, :sexo)
  end
  
end
