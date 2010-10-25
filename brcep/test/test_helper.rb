require 'rubygems'
require 'active_support/test_case'
require 'net/http'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/brcep'

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
