# ÚLTIMO AVISO! 
#
# Os métodos upcase_br e downcase_br serão removidos na próxima versão do plugin,
# então, fique experto! :)
#
# Quem avisa amigo é!

class String

  MINUSCULAS_COM_ACENTO = 'áéíóúâêîôûàèìòùäëïöüãõñç'
  MAIUSCULAS_COM_ACENTO = 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ'
  
  MINUSCULAS = "abcdefghijklmnopqrstuvwxyz#{MINUSCULAS_COM_ACENTO}"
  MAIUSCULAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ#{MAIUSCULAS_COM_ACENTO}"
  
  # Normaliza nomes proprios
  #
  # Exemplo:
  #  'maria de souza dos santos e silva da costa'.nome_proprio ==> 'Maria de Souza dos Santos e Silva da Costa'
  def nome_proprio
    self.titleize.gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e ')
  end
  
  # Remove as letras acentuadas
  # 
  # Exemplo:
  #  'texto está com acentuação'.remover_acentos ==> 'texto esta com acentuacao'
  def remover_acentos
    texto = self
    texto = texto.gsub(/[á|à|ã|â|ä]/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    texto = texto.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    texto
  end
  
  # Retorna uma string com caracteres maiusculos
  # 
  # Exemplo:
  #  'texto com acentuação'.upcase ==> 'TEXTO COM ACENTUAÇÃO'
  def upcase
    self.tr(MINUSCULAS, MAIUSCULAS)
  end
  
  # Alias para upcase
  #
  # AVISO: Este metodo sera removido na proxima revisao, usar o metodo upcase.
  def upcase_br
    RAILS_DEFAULT_LOGGER.warn "AVISO: Este metodo sera removido na proxima revisao, usar o metodo upcase."
    self.upcase
  end  

  # Retorna uma string com caracteres minúsculos
  # 
  # Exemplo:
  #  'TEXTO COM ACENTUAÇÃO'.downcase ==> 'texto com acentuação'
  def downcase
    self.tr(MAIUSCULAS, MINUSCULAS)
  end
  
  # Alias para downcase
  #
  #AVISO: Este metodo sera removido na proxima revisao, usar o metodo downcase.
  def downcase_br
    RAILS_DEFAULT_LOGGER.warn "AVISO: Este metodo sera removido na proxima revisao, usar o metodo downcase."
    self.downcase
  end
  
  # Passa a primeira letra de cada palavra para maiúscula e as demais para minúsculas.
  #
  # Exemplo:
  #  'o livro esta sobre a mesa!'.titleize ==> 'O Livro Esta Sobre A Mesa!'
  def titleize
    texto = self.downcase
    texto.chars[0] = texto.chars.first.upcase
    texto = texto.gsub(/\s[a-z#{String::MINUSCULAS_COM_ACENTO}]/) {|a| a.upcase }
    texto
  end
  
  # Normaliza nomes proprios na própria instância.
  #
  # Exemplo:
  #  texto = 'maria de souza dos santos e silva da costa'
  #  texto.nome_proprio!
  #  texto ==> 'Maria de Souza dos Santos e Silva da Costa'
  def nome_proprio!
    texto = self.nome_proprio
    self.gsub!(/^.*$/, texto)
  end

  # Remove as letras acentuadas na própria instância.
  # 
  # Exemplo:
  #  texto = 'texto está com acentuação'
  #  texto.remover_acentos!
  #  texto ==> 'texto esta com acentuacao'
  def remover_acentos!
    texto = self.remover_acentos
    self.gsub!(/^.*$/, texto)
  end

  # Converte para caracteres maiusculos na própria instância
  # 
  # Exemplo:
  #  texto = 'texto com acentuação'
  #  texto.upcase
  #  texto ==> 'TEXTO COM ACENTUAÇÃO'
  def upcase!
    texto = self.upcase
    self.gsub!(/^.*$/, texto)
  end

  # Converte para caracteres minúsculos na própria instância
  # 
  # Exemplo:
  #  texto = 'TEXTO COM ACENTUAÇÃO'
  #  texto.downcase
  #  texto ==> 'texto com acentuação'
  def downcase!
    texto = self.downcase
    self.gsub!(/^.*$/, texto)
  end

  # Passa a primeira letra de cada palavra para maiúscula e as demais para minúsculas na própria instância.
  #
  # Exemplo:
  #  texto = 'o livro esta sobre a mesa!'
  #  texto.titleize!
  #  texto ==> 'O Livro Esta Sobre A Mesa!'
  def titleize!
    texto = self.titleize
    self.gsub!(/^.*$/, texto)
  end  

  include DinheiroUtil
  
end

