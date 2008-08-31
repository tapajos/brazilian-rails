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
  
  # Retorna o valor armazenado em string.
  #
  # Exemplo:
  #  1000.to_s ==> '1.000,00'
  def to_s
    inteiro_com_milhar(parte_inteira) + parte_decimal
  end
  
  # Compara com outro dinheiro se eh igual.
  #
  # Exemplo:
  #  um_real = Dinheiro.new(1)
  #  um_real == Dinheiro.new(1) ==> true
  #  um_real == Dinheiro.new(2) ==> false
  def ==(outro_dinheiro)
    begin 
      outro_dinheiro = Dinheiro.new(outro_dinheiro) unless outro_dinheiro.kind_of?(Dinheiro)
    rescue
      return false
    end
    @quantia == outro_dinheiro.quantia
  end
  
  # Compara com outro dinheiro se eh maior ou menor.
  #
  # Exemplo:
  #  1.real < 2.reais ==> true
  #  1.real > 2.reais ==> false
  #  2.real < 1.reais ==> false
  #  2.real > 1.reais ==> true
  def <=>(outro_dinheiro)
    outro_dinheiro = Dinheiro.new(outro_dinheiro) unless outro_dinheiro.kind_of?(Dinheiro)
    @quantia <=> outro_dinheiro.quantia
  end
  
  # Retorna a adicao entre dinheiros.
  #
  # Exemplo:
  #  1.real + 1.real == 2.reais 
  #  1.real + 1 == 2.reais 
  def +(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia + quantia_de(outro)))
  end
  
  # Retorna a subtracao entre dinheiros.
  #
  # Exemplo:
  #  10.reais - 2.reais == 8.reais 
  #  10.reais - 2 == 8.reais 
  def -(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia - quantia_de(outro)))
  end
  
  # Retorna a multiplicacao entre dinheiros.
  #
  # Exemplo:
  #  5.reais * 2 == 10.reais
  #  5.reais * 2.reais == 10.reais
  def *(outro)
    return Dinheiro.new(to_f * outro) unless outro.kind_of? Dinheiro
    outro * to_f
  end
  
  # Retorna a divisao entre dinheiros.
  #
  # Exemplo:
  #  5.reais / 2 == (2.5).reais
  #  5.reais / 2.reais == DivisaPorNaoEscalarError
  #  5.reais / 0 == ZeroDivisionError
  #
  # Veja também o método parcelar
  def /(outro)
    raise DivisaPorNaoEscalarError unless outro.kind_of?(Numeric)
    return @quantia/outro if outro == 0
    Dinheiro.new(to_f / outro.to_f)
  end

  # Retorna um array de dinheiro com as parcelas
  #
  # Exemplo:
  #  6.reais.parcelar(2) == [3.reais, 3.reais]
  #  6.reais.parcelar(2.reais) == DisivaPorNaoEscalarError
  #  6.reais.parcelar(0) == ZeroDivisionError
  def parcelar(numero_de_parcelar)
    raise DivisaPorNaoEscalarError unless numero_de_parcelar.kind_of?(Integer)
    resto = @quantia % numero_de_parcelar
    valor_menor = Dinheiro.new((@quantia/numero_de_parcelar)/100.0)
    valor_maior = Dinheiro.new((@quantia/numero_de_parcelar+1)/100.0)
    [valor_menor] * (numero_de_parcelar - resto) + [valor_maior] * resto
  end
  
  # Escreve o valor por extenso.
  # 
  # Exemplo:
  #  1.real.to_extenso ==> 'um real'
  #  (100.58).to_extenso ==> 'cem reais e cinquenta e oito centavos'
  def to_extenso
    (@quantia/100.0).por_extenso_em_reais
  end
  
  # Alias para o metodo to_extenso.
  alias_method :por_extenso, :to_extenso
  
  # Alias para o metodo to_extenso.
  alias_method :por_extenso_em_reais, :to_extenso
  
  # Verifica se o valor é zero.
  def zero?
    to_f.zero?
  end
  
  # Retorna um Float.
  def to_f
    to_s.gsub('.', '').gsub(',', '.').to_f
  end
  
  def coerce(outro)#:nodoc:
    [ Dinheiro.new(outro), self ]
  end
  
  # Retorna a própria instância/
  def real
    self
  end
  
  # Alias para real.
  alias_method :reais, :real
  
  # Retorna uma string formatada com sigla em valor monetário.
  # Exemplo:
  #  Dinheiro.new(1).real_formatado ==> 'R$ 1,00'
  #  Dinheiro.new(-1).real_formatado ==> 'R$ -1,00'
  def real_formatado
    "R$ #{to_s}"
  end
  
  # Alias para real_formatado.
  alias_method :reais_formatado, :real_formatado
  
  # Retorna uma string formatada com sigla em valor contábil.
  #
  # Exemplo:
  #  Dinheiro.new(1).real_contabil ==> 'R$ 1,00'
  #  Dinheiro.new(-1).real_contabil ==> 'R$ (1,00)'
  def real_contabil
    "R$ " + contabil
  end
  
  # Alias para real_contabil.
  alias_method :reais_contabeis, :real_contabil
  
  # Retorna uma string formatada sem sigla.
  #
  # Exemplo:
  #  Dinheiro.new(1).contabil ==> '1,00'
  #  Dinheiro.new(-1).contabil ==> '(1,00)'
  def contabil
    if @quantia >= 0
      to_s      
    else  
      "(" + to_s[1..-1] + ")"    
    end  
  end
  
  # Method missing para retorna um BigDecinal quando chamada .
  def method_missing(symbol, *args) #:nodoc:
    #Ex: Chama ao método valor_decimal() 
    if (symbol.to_s =~ /^(.*)_decimal$/) && args.size == 0
      BigDecimal.new quantia_sem_separacao_milhares.gsub(',','.')
    else
      super.method_missing(symbol, *args)
    end
  end

  private
  def quantia_de(outro)
    outro = outro.to_f if outro.kind_of?(BigDecimal)
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
    quantia = quantia.to_f if quantia.kind_of?(BigDecimal)
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
