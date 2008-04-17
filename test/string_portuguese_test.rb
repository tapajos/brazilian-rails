require File.dirname(__FILE__) + '/test_helper'

NOMES_PROPRIOS = {
  'Paulo Gomes' => 'paulo gomes',
  'Pedro da Silva' => 'pedro da silva',
  'Jonas de Souza' => 'jonas de souza',
  'Maria do Carmo' => 'maria do carmo',
  'Silva e Souza' => 'silva e souza',
  'Jardim das Oliveiras' => 'jardim das oliveiras',
  'José dos Santos' => 'josé dos santos',
  'Tomé Gomes da Silva de Souza' => 'tomé gomes da silva de souza',
  'Maria do Carmo e Souza das Couves dos Santos' => 'maria do carmo e souza das couves dos santos',
  'Átila da Silva' => 'átila da silva',
  'Érica da Silva' => 'érica da silva',
  'Íris Santos' => 'íris santos',
  'Paulo dos Santos' => 'paulo dos saNTos',
  ' José  da   Silva  ' => ' josé  da   silva  '
}

class StringPortugueseTest < Test::Unit::TestCase
  def test_nome_proprio
    NOMES_PROPRIOS.each {|key, value| assert_equal key, value.nome_proprio }
    
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
  
  def test_downcase
    assert_equal String::MINUSCULAS_COM_ACENTO, String::MAIUSCULAS_COM_ACENTO.downcase
  end
  
  def test_upcase
    assert_equal String::MAIUSCULAS_COM_ACENTO, String::MINUSCULAS_COM_ACENTO.upcase
  end

  def test_downcase_br
    RAILS_DEFAULT_LOGGER.expects(:warn).with("AVISO: Este metodo sera removido na proxima revisao, usar o metodo downcase.")
    assert_equal String::MINUSCULAS_COM_ACENTO, String::MAIUSCULAS_COM_ACENTO.downcase_br
  end
  
  def test_upcase_br
    RAILS_DEFAULT_LOGGER.expects(:warn).with("AVISO: Este metodo sera removido na proxima revisao, usar o metodo upcase.")
    assert_equal String::MAIUSCULAS_COM_ACENTO, String::MINUSCULAS_COM_ACENTO.upcase_br
  end
  
  def test_titleize
    assert_equal 'José Silva', 'josé silva'.titleize
    assert_equal 'José Silva', 'JOSÉ SILVA'.titleize
    assert_equal 'José Da Silva', 'josé da silva'.titleize
    assert_equal ' José  Da   Silva  ', ' josé  da   silva  '.titleize
    assert_equal 'Átila Da Silva', 'átila da silva'.titleize
    assert_equal "Á É Í Ó Ú À È Ì Ò Ù Ã Õ Â Ê Î Ô Û Ä Ë Ï Ö Ü", 'á é í ó ú à è ì ò ù ã õ â ê î ô û ä ë ï ö ü'.titleize
end

  def test_nome_proprio!
    string = 'joão Dos santos'
    string.nome_proprio!
    assert_equal 'João dos Santos', string
  end

  def test_remover_acentos!
    string = 'áéíóúÁÉÍÓÚ'
    string.remover_acentos!
    assert_equal 'aeiouAEIOU', string
  end

  def test_upcase!
    string = 'áéíóúâêîôûàèìòùäëïöüãõñç'
    string.upcase!
    assert_equal 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ', string
  end

  def test_downcase!
    string = 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ'
    string.downcase!
    assert_equal 'áéíóúâêîôûàèìòùäëïöüãõñç', string
  end  
end
