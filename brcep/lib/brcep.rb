require "brcep/version"

module BrCep

  def self.ativar_busca_endereco
    require "brcep/busca_endereco"
    require "brcep/cep"
  end

  def self.setup
    yield self
  end
end
