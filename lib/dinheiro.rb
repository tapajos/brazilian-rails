class Dinheiro
  
  include Comparable
  
  attr_reader :quantia
  
  FORMATO_VALIDO_BR  = /^([R|r]\$\s*)?(([+-]?\d{1,3}(\.?\d{3})*))?(\,\d{0,2})?$/
  FORMATO_VALIDO_EUA = /^([R|r]\$\s*)?(([+-]?\d{1,3}(\,?\d{3})*))?(\.\d{0,2})?$/
  SEPARADOR_MILHAR = "."
  SEPARADOR_FRACIONARIO = ","
  QUANTIDADE_DIGITOS = 3
  PRECISAO_DECIMAL = 100
  
  def initialize(quantia)
    self.quantia = quantia
  end
  
  def to_s
    inteiro_com_milhar(parte_inteira) + parte_decimal
  end
  
  def ==(outro_dinheiro)
    outro_dinheiro = Dinheiro.new(outro_dinheiro) unless outro_dinheiro.kind_of?(Dinheiro)
    @quantia == outro_dinheiro.quantia
  end
  
  def <=>(outro_dinheiro)
    outro_dinheiro = Dinheiro.new(outro_dinheiro) unless outro_dinheiro.kind_of?(Dinheiro)
    @quantia <=> outro_dinheiro.quantia
  end
  
  def +(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia + quantia_de(outro)))
  end
  
  def -(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia - quantia_de(outro)))
  end
  
  def *(outro)
    return Dinheiro.new(to_f * outro) unless outro.kind_of? Dinheiro
    outro * to_f
  end
  
  def /(outro)
    raise DivisaPorNaoEscalarError unless outro.kind_of?(Numeric)
    return @quantia/outro if outro == 0
    soma_parcial = Dinheiro.new(0)
    parcelas = []
    (outro-1).times do
      parcela = Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia/outro))
      parcelas << parcela
      soma_parcial += parcela
    end
    parcelas << Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia - quantia_de(soma_parcial)))
  end
  
  def to_extenso
    (@quantia/100.0).to_extenso_real
  end
  
  def to_f
    to_s.gsub(',', '.').to_f
  end
  
  def coerce(outro)
    [ Dinheiro.new(outro), self ]
  end
  
  def real
    "R$ " + to_s
  end
  
  def real_contabil
    "R$ " + contabil
  end
  
  def reais
    real
  end
  
  def reais_contabeis
    real_contabil
  end  
  
  def contabil
    if @quantia >= 0
      to_s      
    else  
      "(" + to_s[1..-1] + ")"    
    end  
  end
  
  private
  
  def quantia_de(outro)
    return outro.quantia if outro.kind_of?(Dinheiro)
    (outro * 100).round
  end
  
  def transforma_em_string_que_represente_a_quantia(quantia)
    if /^([+-]?)(\d)$/ =~ quantia.to_s
      return "#{$1}0.0#{$2}"
    end
    /^([+-]?)(\d*)(\d\d)$/ =~ quantia.to_s
    "#{$1}#{$2.to_i}.#{$3}"
  end
  
  def quantia=(quantia)
    raise DinheiroInvalidoError unless quantia_valida?(quantia)
    @quantia = (quantia * 100).round if quantia.kind_of?(Numeric)
    @quantia = extrai_quantia_como_inteiro(quantia) if quantia.kind_of?(String)
  end
  
  def parte_inteira
    quantia_sem_separacao_milhares[0,quantia_sem_separacao_milhares.length-QUANTIDADE_DIGITOS]
  end
  
  def parte_decimal
    quantia_sem_separacao_milhares[-QUANTIDADE_DIGITOS, QUANTIDADE_DIGITOS]
  end
  
  def inteiro_com_milhar(inteiro)
    return inteiro if quantidade_de_passos(inteiro) == 0
    resultado = ""
    quantidade_de_passos(inteiro).times do |passo| 
      resultado = "." + inteiro[-QUANTIDADE_DIGITOS + passo * -QUANTIDADE_DIGITOS, QUANTIDADE_DIGITOS] + resultado            
    end
    resultado = inteiro[0, digitos_que_sobraram(inteiro)] + resultado
    resultado.gsub(/^(-?)\./, '\1')
  end
  
  def quantia_sem_separacao_milhares
    sprintf("%.2f", (@quantia.to_f / PRECISAO_DECIMAL)).gsub(SEPARADOR_MILHAR, SEPARADOR_FRACIONARIO)
  end  
  
  def quantidade_de_passos(inteiro)
    resultado = inteiro.length / QUANTIDADE_DIGITOS
    resultado = (resultado - 1) if inteiro.length % QUANTIDADE_DIGITOS == 0
    resultado
  end
  
  def digitos_que_sobraram(inteiro)
    inteiro.length - (quantidade_de_passos(inteiro) * QUANTIDADE_DIGITOS)
  end
  
  def quantia_valida?(quantia)
    return false if quantia.kind_of?(String) && !quantia_respeita_formato?(quantia)
    quantia.kind_of?(String) || quantia.kind_of?(Numeric)
  end
   
  def extrai_quantia_como_inteiro(quantia)
    if FORMATO_VALIDO_BR =~ quantia
      return sem_milhar($2, $5, '.')
    end
    if FORMATO_VALIDO_EUA =~ quantia 
      return sem_milhar($2, $5, ',')
    end
  end
  
  def sem_milhar(parte_inteira, parte_decimal, delimitador_de_milhar)
    (inteiro(parte_inteira, delimitador_de_milhar) + decimal(parte_decimal)).to_i
  end
  
  def inteiro(inteiro_com_separador_milhar, separador)
    return inteiro_com_separador_milhar.gsub(separador, '') unless inteiro_com_separador_milhar.blank?
    ""
  end
  
  def decimal(parte_fracionaria)
    unless parte_fracionaria.blank?
      return sem_delimitador_decimal(parte_fracionaria) if parte_fracionaria.length == 3
      return sem_delimitador_decimal(parte_fracionaria) + "0" if parte_fracionaria.length == 2
    end
    "00"
  end
  
  def sem_delimitador_decimal(parte_fracionaria)
    "#{parte_fracionaria}".gsub(/[.|,]/, '')
  end
  
  
  def quantia_respeita_formato?(quantia)
    return true if FORMATO_VALIDO_BR.match(quantia) || FORMATO_VALIDO_EUA.match(quantia)
    false
  end
  
end
