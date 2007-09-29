require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class StringPortugueseTest < Test::Unit::TestCase
  def test_nome_proprio
    assert_equal "Celestino Gomes", "celestino gomes".nome_proprio
    assert_equal "Celestino da Silva", "celestino da silva".nome_proprio
    assert_equal "Celestino de Souza", "celestino de souza".nome_proprio
    assert_equal "Celestino do Carmo", "celestino do carmo".nome_proprio
    assert_equal "Celestino e Souza", "celestino e souza".nome_proprio
    assert_equal "Celestino das Couves", "celestino das couves".nome_proprio
    assert_equal "Celestino dos Santos", "celestino dos santos".nome_proprio
    assert_equal "Celestino Gomes da Silva de Souza do Carmo e Souza das Couves dos Santos", "celestino gomes da silva de souza do carmo e souza das couves dos santos".nome_proprio
    assert_equal 'Maria João da Silva', 'MariaJoão da silva'.nome_proprio
    assert_equal "Átila da Silva", 'átila da silva'.nome_proprio
    assert_equal "Érica da Silva", 'érica da silva'.nome_proprio
    assert_equal "Íris Santos", 'íris santos'.nome_proprio
    
    palavras_excluidas = %w(? ! @ # $ % & * \ / ? , . ; ] [ } { = + 0 1 2 3 4 5 6 7 8 9)
    
    palavras_excluidas.each do |char|
      assert_equal char, char.nome_proprio, "Não deveria alterar o caracter '#{char}'"
    end
  end
  
  def test_remover_acentos
    assert_equal 'aeiouAEIOU', "áéíóúÁÉÍÓÚ".remover_acentos
    assert_equal 'aeiouAEIOU', "âêîôûÂÊÎÔÛ".remover_acentos
    assert_equal 'aeiouAEIOU', "àèìòùÀÈÌÒÙ".remover_acentos
    assert_equal 'aeiouAEIOU', "äëïöüÄËÏÖÜ".remover_acentos
    assert_equal 'aoAO', "ãõÃÕ".remover_acentos
    assert_equal 'nN', "ñÑ".remover_acentos
    assert_equal 'cC', "çÇ".remover_acentos
    assert_equal 'aeiouAEIOUaeiouAEIOUaeiouAEIOUaeiouAEIOUaoAOnNcC', "áéíóúÁÉÍÓÚâêîôûÂÊÎÔÛàèìòùÀÈÌÒÙäëïöüÄËÏÖÜãõÃÕñÑçÇ".remover_acentos
  end
  
  def test_downcase_br
    assert_equal 'áéíóúâêîôûàèìòùäëïöüãõñç', 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ'.downcase_br
  end
  
  def test_upcase_br
    assert_equal 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ', 'áéíóúâêîôûàèìòùäëïöüãõñç'.upcase_br
  end
  
end
