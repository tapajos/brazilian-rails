$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
module BrCobranca
end

["boleto/banco", "boleto/banco_do_brasil"].each {|req| require File.dirname(__FILE__) + "/brcobranca/#{req}"}
