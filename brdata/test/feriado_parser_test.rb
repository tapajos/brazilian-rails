# encoding: UTF-8
require "test_helper"

class FeriadoParserTest < ActiveSupport::TestCase
  
  def setup
    BrData.setup do |config|
      config.ativar_feriados
    end
    @feriado_yml_path = File.expand_path(File.dirname(__FILE__) + '/../lib/brdata/config')    
    @natal = Feriado.new("natal", 25, 12)
  end

  test "Feriados" do
    feriados, metodos = FeriadoParser.parser(@feriado_yml_path)
    feriados.each {|feriado| assert_kind_of Feriado, feriado}
    assert_equal @natal, feriados.find {|f| f.nome == "natal"}
    assert metodos.include?( "pascoa") 
    assert metodos.include?( "corpus_christi")
  end
  
  test "Feriados quando path não é diretório" do
    assert_raise  FeriadoParserDiretorioInvalidoError do
      FeriadoParser.parser(File.dirname(__FILE__) + 'dinheiro_test.rb')  
    end
  end
  
  test "Feriados quando path não contem arquivos" do
    assert_raise  FeriadoParserDiretorioVazioError do
      FeriadoParser.parser(File.dirname(__FILE__))  
    end
  end
  
end
