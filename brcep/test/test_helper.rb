require 'test/unit'
require File.dirname(__FILE__) + '/../lib/brcep'


def tornar_metodos_publicos(clazz)
  clazz.class_eval do
    private_instance_methods.each { |instance_method| public instance_method }
    private_methods.each { |method| public_class_method method } 
  end  
end

def p80 text
  p '*'*80
  p text
  yield if block_given?
end



class MockSuccess < Net::HTTPSuccess
  def initialize; end
end

class MockServerError < Net::HTTPServerError
  def initialize; 
    @message = 'HTTPServiceUnavailable'
    @code = '504'
  end
end

def limpa_cep(numero)
  numero.to_s.gsub(/\./, '').gsub(/\-/, '')
end
