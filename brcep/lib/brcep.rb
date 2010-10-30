%w(version).each {|req| require File.dirname(__FILE__) + "/brcep/#{req}"}
module BrCep

  def self.ativar_busca_endereco
    require File.dirname(__FILE__) + "/brcep/busca_endereco"
  end

  def self.setup
    yield self
  end
end
