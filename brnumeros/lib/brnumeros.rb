require "brnumeros/number_portuguese"
require "brnumeros/version"

module BrNumeros

  Numeric.send(:include, ExtensoReal)

  def self.setup
    yield self
  end

  def self.mensagem_zero_reais=(message)
    ExtensoReal.mensagem_zero_reais(message) 
  end
end
