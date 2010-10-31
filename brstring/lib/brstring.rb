%w(version).each {|req| require File.dirname(__FILE__) + "/brstring/#{req}"}

module BrString
  def self.setup
    yield self 
  end

  private
  def self.ativar_brstring
    require File.dirname(__FILE__) + "/brstring/string_portuguese.rb" 
  end
end

