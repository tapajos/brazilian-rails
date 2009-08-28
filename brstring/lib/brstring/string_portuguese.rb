# encoding: UTF-8
class String
  MINUSCULAS_COM_ACENTO = 'áéíóúâêîôûàèìòùäëïöüãõñç'
  MAIUSCULAS_COM_ACENTO = 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ'

  MINUSCULAS = "abcdefghijklmnopqrstuvwxyz#{MINUSCULAS_COM_ACENTO}"
  MAIUSCULAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#{MAIUSCULAS_COM_ACENTO}"

  # Normaliza nomes proprios
  #
  # Exemplo:
  #  String.nome_proprio('maria de souza dos santos e silva da costa') ==> 'Maria de Souza dos Santos e Silva da Costa'
  def self.nome_proprio(texto)
    return texto if texto.blank?
    self.titleize(texto).gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e ')
  end

  # Normaliza nomes proprios
  #
  # Exemplo:
  #  'maria de souza dos santos e silva da costa'.nome_proprio ==> 'Maria de Souza dos Santos e Silva da Costa'
  def nome_proprio
    String.nome_proprio(self)
  end

  # Normaliza nomes proprios na própria instância.
  #
  # Exemplo:
  #  texto = 'maria de souza dos santos e silva da costa'
  #  texto.nome_proprio!
  #  texto ==> 'Maria de Souza dos Santos e Silva da Costa'
  def nome_proprio!
    self.gsub!(/^.*$/, String.nome_proprio(self)) if self
  end

  # Remove as letras acentuadas
  #
  # Exemplo:
  #  String.remover_acentos('texto está com acentuação') ==> 'texto esta com acentuacao'
  def self.remover_acentos(texto)
    return texto if texto.blank?
    texto = texto.gsub(/[á|à|ã|â|ä]/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    texto = texto.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    texto
  end

  # Remove as letras acentuadas
  #
  # Exemplo:
  #  'texto está com acentuação'.remover_acentos ==> 'texto esta com acentuacao'
  def remover_acentos
    String.remover_acentos(self)
  end

  # Remove as letras acentuadas na própria instância.
  #
  # Exemplo:
  #  texto = 'texto está com acentuação'
  #  texto.remover_acentos!
  #  texto ==> 'texto esta com acentuacao'
  def remover_acentos!
    self.gsub!(/^.*$/, String.remover_acentos(self)) if self
  end

  # Retorna uma string com caracteres maiusculos
  #
  # Exemplo:
  #  String.upcase('texto com acentuação' ==> 'TEXTO COM ACENTUAÇÃO'
  def self.upcase(texto)
    return texto if texto.blank?
    texto.tr(MINUSCULAS, MAIUSCULAS)
  end

  # Retorna uma string com caracteres maiusculos
  #
  # Exemplo:
  #  'texto com acentuação'.upcase ==> 'TEXTO COM ACENTUAÇÃO'
  def upcase
    String.upcase(self)
  end

  # Converte para caracteres maiusculos na própria instância
  #
  # Exemplo:
  #  texto = 'texto com acentuação'
  #  texto.upcase
  #  texto ==> 'TEXTO COM ACENTUAÇÃO'
  def upcase!
    self.gsub!(/^.*$/, String.upcase(self)) if self
  end

  # Retorna uma string com caracteres minúsculos
  #
  # Exemplo:
  #  String.downcase('TEXTO COM ACENTUAÇÃO') ==> 'texto com acentuação'
  def self.downcase(texto)
    return texto if texto.blank?
    texto.tr(MAIUSCULAS, MINUSCULAS)
  end

  # Retorna uma string com caracteres minúsculos
  #
  # Exemplo:
  #  'TEXTO COM ACENTUAÇÃO'.downcase ==> 'texto com acentuação'
  def downcase
    String.downcase(self)
  end

  # Converte para caracteres minúsculos na própria instância
  #
  # Exemplo:
  #  texto = 'TEXTO COM ACENTUAÇÃO'
  #  texto.downcase
  #  texto ==> 'texto com acentuação'
  def downcase!
    self.gsub!(/^.*$/, String.downcase(self)) if self
  end

  # Passa a primeira letra de cada palavra para maiúscula e as demais para minúsculas.
  #
  # Exemplo:
  #  String.titleize('o livro esta sobre a mesa!') ==> 'O Livro Esta Sobre A Mesa!'
  def self.titleize(texto)
    return texto if texto.blank?
    texto = texto.downcase
    texto = texto.downcase
    texto.mb_chars[0] = texto.mb_chars.first.upcase
    texto = texto.gsub(/\s[a-z#{String::MINUSCULAS_COM_ACENTO}]/) {|a| a.upcase }
    texto
  end

  # Passa a primeira letra de cada palavra para maiúscula e as demais para minúsculas.
  #
  # Exemplo:
  #  'o livro esta sobre a mesa!'.titleize ==> 'O Livro Esta Sobre A Mesa!'
  def titleize
    String.titleize(self)
  end

  # Passa a primeira letra de cada palavra para maiúscula e as demais para minúsculas na própria instância.
  #
  # Exemplo:
  #  texto = 'o livro esta sobre a mesa!'
  #  texto.titleize!
  #  texto ==> 'O Livro Esta Sobre A Mesa!'
  def titleize!
    self.gsub!(/^.*$/, String.titleize(self)) if self
  end
  

end
