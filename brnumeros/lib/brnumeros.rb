%w(number_portuguese version).each {|req| require File.dirname(__FILE__) + "/brnumeros/#{req}"}

module BrNumeros
  def self.setup
    yield self
  end

  private
  def self.ativar_numeros_extensos
    Numeric.send(:include, ExtensoReal)
  end

end
