# == Como usar o Dinheiro em seu ActiveRecord?
# 
# * Arquivo 001_create_lancamentos.rb:
# 
#     class CreateLancamentos < ActiveRecord::Migration
#       def self.up
#         create_table :lancamentos do |t|
#           t.column :descricao,   :string,    :null => false
#           t.column :valor,       :decimal,   :precision => 14, :scale => 2
#           t.column :mensalidade, :decimal,   :precision => 14, :scale => 2
#         end
#       end
#
#       def self.down
#         drop_table :lancamentos
#       end
#     end
# 
# * Arquivo lancamento.rb:
# 
#     class Lancamento < ActiveRecord::Base
#       usar_como_dinheiro :valor, :mensalidade
#     end
#
# * No console (script/console):
# 
#     Loading development environment.
#     >> lancamento = Lancamento.new
#     => #<Lancamento:0x9652cd8 @attributes={"descricao"=>nil, 
#                                            "valor"=>#<BigDecimal:9657008,'0.0',4(4)>, 
#                                            "mensalidade"=>#<BigDecimal:9656e8c,'0.0',4(4)>}, 
#                               @new_record=true>
#     >> lancamento.valor = 100
#     => 100
#     >> lancamento.valor
#     => #<Dinheiro:0x9650f3c @quantia=10000>
#     >> lancamento.valor.real
#     => "R$ 100,00"
#     >> lancamento.valor = 100.50
#     => 100.5
#     >> lancamento.valor.real
#     => "R$ 100,50"
#     >> lancamento.valor = "250.50"
#     => "250.50"
#     >> lancamento.valor.real
#     => "R$ 250,50"
#     >> lancamento.valor = 354.58.reais
#     => #<Dinheiro:0x9646384 @quantia=35458>
#     >> lancamento.valor.real
#     => "R$ 354,58"
#     >> exit
#  
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
    outro_dinheiro = Dinheiro.new(outro_dinheiro) unless outro_dinheiro.kind_of?(Dinheiro)
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
  def +(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia + quantia_de(outro)))
  end
  
  # Retorna a subtracao entre dinheiros.
  def -(outro)
    Dinheiro.new(transforma_em_string_que_represente_a_quantia(@quantia - quantia_de(outro)))
  end
  
  # Retorna a multiplicacao entre dinheiros.
  def *(outro)
    return Dinheiro.new(to_f * outro) unless outro.kind_of? Dinheiro
    outro * to_f
  end
  
  # Retorna a divisao entre dinheiros.
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
  
  # Escreve o valor por extenso.
  # 
  # Exemplo:
  #  1.real.por_extenso ==> 'um real'
  #  (100.58).por_extenso ==> 'cem reais e cinquenta e oito centavos'
  def por_extenso
    (@quantia/100.0).por_extenso_em_reais
  end
  
  # Alias para o metodo por_extenso.
  alias_method :por_extenso_em_reais, :por_extenso
  
  # DEPRECATION WARNING: use por_extenso ou por_extenso_em_reais, pois este sera removido no proximo release.
  def to_extenso
    warn("DEPRECATION WARNING: use por_extenso ou por_extenso_em_reais, pois este sera removido no proximo release.")
    self.por_extenso
  end
  
  # Retorna um Float.
  def to_f
    to_s.gsub('.', '').gsub(',', '.').to_f
  end
  
  def coerce(outro)
    [ Dinheiro.new(outro), self ]
  end
  
  # Retorna a própria instância/
  def real
    self
  end
  
  # Retorna o dinheiro formatado
  # Exemplo:
  #  Dinheiro.new(1).real ==> 'R$ 1,00'
  #  Dinheiro.new(-1).real ==> 'R$ -1,00'
  def real_formatado
    "R$ #{to_s}"
  end
  
  # Retorna uma string formatada em valor monetario.
  #
  # Exemplo:
  #  Dinheiro.new(1).real ==> 'R$ 1,00'
  #  Dinheiro.new(-1).real ==> 'R$ (1,00)'
  def real_contabil
    "R$ " + contabil
  end
  
  # Alias para real.
  alias_method :reais, :real
  
  # Alias para real_contabil.
  alias_method :reais_contabeis, :real_contabil
  
  # Retorna uma string formatada.
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
  
  # Retorna um BigDecinal.
  def valor_decimal
    BigDecimal.new quantia_sem_separacao_milhares.gsub(',','.')
  end
    
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
