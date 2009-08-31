# encoding: UTF-8
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
  ' José  da   Silva  ' => ' josé  da   silva  ',
  '' => ''
} #:nodoc:

NOMES_TITLEIZE =     {
    'José Silva' => 'josé silva',    
    'José Silva' => 'JOSÉ SILVA',
    'José Da Silva' => 'josé da silva',
    ' José  Da   Silva  ' => ' josé  da   silva  ',
    'Átila Da Silva' => 'átila da silva',
    "Á É Í Ó Ú À È Ì Ò Ù Ã Õ Â Ê Î Ô Û Ä Ë Ï Ö Ü" => 'á é í ó ú à è ì ò ù ã õ â ê î ô û ä ë ï ö ü'
} #:nodoc:

class StringPortugueseTest < Test::Unit::TestCase  
  def test_letras_maiusculas
    assert_equal 'ABCDEFGHIJKLMNOPQRSTUVWXYZÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ', String::MAIUSCULAS
  end

  def test_letras_minusculas
    assert_equal 'abcdefghijklmnopqrstuvwxyzáéíóúâêîôûàèìòùäëïöüãõñç', String::MINUSCULAS
  end
  
  def test_string_nome_proprio
    NOMES_PROPRIOS.each {|key, value| assert_equal key, String.nome_proprio(value) }
    
    palavras_excluidas = %w(? ! @ # $ % & * \ / ? , . ; ] [ } { = + 0 1 2 3 4 5 6 7 8 9)
    
    palavras_excluidas.each do |char|
      assert_equal char, String.nome_proprio(char), "Não deveria alterar o caracter '#{char}'"
    end
    
    assert_nil String.nome_proprio(nil)
  end

  def test_nome_proprio
    NOMES_PROPRIOS.each {|key, value| assert_equal key, value.nome_proprio }
    
    palavras_excluidas = %w(? ! @ # $ % & * \ / ? , . ; ] [ } { = + 0 1 2 3 4 5 6 7 8 9)
    
    palavras_excluidas.each do |char|
      assert_equal char, char.nome_proprio, "Não deveria alterar o caracter '#{char}'"
    end
  end
  
  def test_nome_proprio!
    NOMES_PROPRIOS.each do |key, value| 
      nome = value
      nome.nome_proprio!
      assert_equal key, nome
    end
    
    palavras_excluidas = %w(? ! @ # $ % & * \ / ? , . ; ] [ } { = + 0 1 2 3 4 5 6 7 8 9)
    
    palavras_excluidas.each do |char|
      nome = char.clone
      nome.nome_proprio!
      assert_equal char, nome, "Não deveria alterar o caracter '#{char}'"
    end
  end

  def test_string_remover_acentos
    assert_equal 'aeiouAEIOU', String.remover_acentos("áéíóúÁÉÍÓÚ")
    assert_equal 'aeiouAEIOU', String.remover_acentos("âêîôûÂÊÎÔÛ")
    assert_equal 'aeiouAEIOU', String.remover_acentos("àèìòùÀÈÌÒÙ")
    assert_equal 'aeiouAEIOU', String.remover_acentos("äëïöüÄËÏÖÜ")
    assert_equal 'aoAO', String.remover_acentos("ãõÃÕ")
    assert_equal 'nN', String.remover_acentos("ñÑ")
    assert_equal 'cC', String.remover_acentos("çÇ")
    assert_equal 'aeiouAEIOUaeiouAEIOUaeiouAEIOUaeiouAEIOUaoAOnNcC', String.remover_acentos("áéíóúÁÉÍÓÚâêîôûÂÊÎÔÛàèìòùÀÈÌÒÙäëïöüÄËÏÖÜãõÃÕñÑçÇ")
    assert_nil String.remover_acentos(nil)
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
  
  def test_remover_acentos!
    string = 'áéíóúÁÉÍÓÚ'
    string.remover_acentos!
    assert_equal 'aeiouAEIOU', string
  end

  def test_string_downcase
    assert_equal String::MINUSCULAS, String.downcase(String::MAIUSCULAS)
    assert_nil String.downcase(nil)
  end
  
  def test_downcase
    assert_equal String::MINUSCULAS, String::MAIUSCULAS.downcase
  end
  
  def test_downcase!
    string = String::MAIUSCULAS.clone
    string.downcase!
    assert_equal String::MINUSCULAS, string
  end  
  
  def test_string_upcase
    assert_equal String::MAIUSCULAS, String.upcase(String::MINUSCULAS)
    assert_nil String.upcase(nil)
  end

  def test_upcase
    assert_equal String::MAIUSCULAS, String::MINUSCULAS.upcase
  end

  def test_upcase!
    string = String::MINUSCULAS.clone
    string.upcase!
    assert_equal String::MAIUSCULAS, string
  end

  def test_string_titleize
    NOMES_TITLEIZE.each {|k,v| assert_equal k, String.titleize(v) }
    assert_nil String.titleize(nil)
  end

  def test_titleize
    NOMES_TITLEIZE.each {|k,v| assert_equal k, v.titleize }
  end

  def test_titleize!
    NOMES_TITLEIZE.each do |k,v| 
      v.titleize!
      assert_equal k, v
    end
  end

end
