require File.dirname(__FILE__) + '/../test_helper'

class FeriadoParserTest < Test::Unit::TestCase
  
  FERIADO_YML_PATH = File.dirname(__FILE__) + '/../../lib/feriado'
  NATAL = Feriado.new("natal", 25, 12)
  
  def test_feriados
    feriados = FeriadoParser.parser(FERIADO_YML_PATH)
    feriados.each {|feriado| assert_kind_of Feriado, feriado}
    assert_equal NATAL, feriados.first
  end
  
  def test_feriados_quando_path_nao_eh_diretorio
    assert_raise  FeriadoParserDiretorioInvalidoError do
      FeriadoParser.parser(File.dirname(__FILE__) + 'dinheiro_test.rb')  
    end
  end
  
  def test_feriados_quando_path_nao_contem_arquivos
    assert_raise  FeriadoParserDiretorioVazioError do
      FeriadoParser.parser(File.dirname(__FILE__))  
    end
  end
  
  
end
