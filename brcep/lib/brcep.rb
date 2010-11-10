require "brcep/version"
require "active_support/core_ext/module"

module BrCep

  require "brcep/busca_endereco"
  require "brcep/cep"

  #Configuração do endereço de proxy caso seja necessário
  mattr_accessor :proxy_address

  #Configuração da proxy port caso seja necessário
  mattr_accessor :proxy_port

  #Erro para cep inválido
  #:throw lançará uma exception
  #:nil retornará apenas nil
  mattr_accessor :cep_invalido
  @@cep_invalido = :throw

  #Erro para serviços indisponíveis
  #:throw lançará uma exception
  #:nil retornará apenas nil
  mattr_accessor :servico_indisponivel
  @@servico_indisponivel = :throw

  def self.setup
    yield self
  end
end
