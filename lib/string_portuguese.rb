module StringPortuguese
  MINUSCULAS_COM_ACENTO = 'áéíóúâêîôûàèìòùäëïöüãõñç'
  MAIUSCULAS_COM_ACENTO = 'ÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÑÇ'
  
  # Normaliza nomes proprios
  #
  # Exemplo:
  #  'maria de souza dos santos e silva da costa'.nome_proprio ==> 'Maria de Souza dos Santos e Silva da Costa'
  def nome_proprio
    palavras = []
    self.titleize().each do |palavra|
      palavra =~ /^(.)(.*)$/
      palavras << "#{$1.upcase_br}#{$2}"
    end
    palavras.join(' ').gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e ')
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
  #  'texto com acentuação'.upcase_br ==> 'TEXTO COM ACENTUAÇÃO'
  def upcase_br
    self.tr(MINUSCULAS_COM_ACENTO, MAIUSCULAS_COM_ACENTO).upcase
  end

  # Retorna uma string com caracteres minúsculos
  # 
  # Exemplo:
  #  'TEXTO COM ACENTUAÇÃO'.downcase_br ==> 'texto com acentuação'
  def downcase_br
    self.tr(MAIUSCULAS_COM_ACENTO, MINUSCULAS_COM_ACENTO).downcase
  end
end
