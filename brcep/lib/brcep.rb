require "brcep/version"

module BrCep

  def self.ativar_busca_endereco
    require  "brcep/busca_endereco"
  end

  def self.setup
    yield self
  end
end
