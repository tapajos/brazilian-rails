require File.dirname(__FILE__) + '/test_helper'

class FeriadoParserTest < Test::Unit::TestCase
  
  FERIADO_YML_PATH = File.expand_path(File.dirname(__FILE__) + '/../lib/config')
  p FERIADO_YML_PATH
  NATAL = Feriado.new("natal", 25, 12)
  
  def test_feriados
    feriados, metodos = FeriadoParser.parser(FERIADO_YML_PATH)
    feriados.each {|feriado| assert_kind_of Feriado, feriado}
    assert_equal NATAL, feriados.first
    assert_equal ["pascoa", "corpus_christi"], metodos
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
