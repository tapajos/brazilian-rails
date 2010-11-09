require "brcep/version"
require "active_support/core_ext/module"

module BrCep

  require "brcep/busca_endereco"
  require "brcep/cep"

  #Configuração do endereço de proxy caso seja necessário
  mattr_accessor :proxy_address

  #Configuração da proxy port caso seja necessário
  mattr_accessor :proxy_port

  def self.setup
    yield self
  end
end
