require "brnumeros/number_portuguese"
require "brnumeros/version"

module BrNumeros
  def self.setup
    yield self
  end

  private
  def self.ativar_numeros_por_extenso
    Numeric.send(:include, ExtensoReal)
  end

  def self.mensagem_zero_reais=(message)
    ExtensoReal.mensagem_zero_reais(message) 
  end
end
