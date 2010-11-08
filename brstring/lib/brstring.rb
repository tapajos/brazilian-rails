require "brstring/version"

module BrString
  def self.setup
    yield self 
  end

  private
  def self.ativar_brstring
    require "brstring/string_portuguese" 
  end
end

