# encoding: UTF-8
require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'net/http'
require 'mocha'
require 'fakeweb'

FakeWeb.allow_net_connect = false

INVALID_ZIPS = [0, '0', '00', '000', '0000', '00000', '000000', '0000000', '4006000']
VALID_ZIPS = [22640100, '22640100', '22.640100', '22640-100', '22.640-100']
VALID_ZIPS_WITH_ZERO_AT_BEGINNING = ['05145100', '05145-100', '05.145-100']
ZIPS_WITH_NO_ADDRESS_ASSOCIATED = [12345678, '12345678', '12.345678', '12345-678', '12.345-678']

URL = BuscaEndereco::WEB_SERVICE_REPUBLICA_VIRTUAL_URL

class BuscaEnderecoTest < Test::Unit::TestCase
  def test_if_warn_for_por_cep_usage
    cep = VALID_ZIPS.sample
    expected = {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :cidade => 'Rio de Janeiro', :uf => 'RJ', :cep => cep}
    BuscaEndereco.expects(:warn).with("DEPRECATION WARNING: O método `BuscaEnderedo.por_cep` será removido. Use o BuscaEndereco.cep e faça os ajustes necessarios")
    BuscaEndereco.expects(:cep).with(cep).returns(expected)
    
    assert_equal expected.values, BuscaEndereco.por_cep(cep)
  end
  
  def test_raise_without_service_on_both_web_services
    FakeWeb.register_uri(:get, "#{URL}#{22640100}", :status => 504, :body => "Service Unavailable")
    
    assert_raise RuntimeError, "A busca de endereço por CEP está indisponível no momento." do
      BuscaEndereco.cep(22640100)
    end
  end

  INVALID_ZIPS.each do |invalid_zip|
    define_method "test_raise_for_invalid_zip_code_#{invalid_zip}" do
      assert_raise RuntimeError, "O CEP informado possui um formato inválido." do
        BuscaEndereco.cep(invalid_zip)
      end
    end
  end

  VALID_ZIPS.each do |valid_zip|
    define_method "test_valid_code_#{valid_zip}" do
      cep = VALID_ZIPS.first.to_s
      expected = {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :cidade => 'Rio de Janeiro', :uf => 'RJ', :cep => cep}
      body = "&resultado=1&resultado_txt=sucesso+-+cep+completo&uf=RJ&cidade=Rio+de+Janeiro&bairro=Barra+da+Tijuca&tipo_logradouro=Avenida&logradouro=das+Am%E9ricas"

      FakeWeb.register_uri(:get, "#{URL}#{cep}", :body => body)

      assert_equal expected,BuscaEndereco.cep(valid_zip)
    end
  end
  
  VALID_ZIPS_WITH_ZERO_AT_BEGINNING.each do |valid_zip|
    define_method "test_valid_code_#{valid_zip}" do
      cep = VALID_ZIPS_WITH_ZERO_AT_BEGINNING.first
      expected = {:tipo_logradouro => "Avenida", :logradouro => "Raimundo Pereira de Magalhães", :bairro => "Jardim Iris", :cidade => "São Paulo", :uf => "SP", :cep => cep}
      body = "&resultado=1&resultado_txt=sucesso+-+cep+completo&uf=SP&cidade=S%E3o+Paulo&bairro=Jardim+Iris&tipo_logradouro=Avenida&logradouro=Raimundo+Pereira+de+Magalh%E3es"
      
      FakeWeb.register_uri(:get, "#{URL}#{cep}", :body => body)
  
      assert_equal expected, BuscaEndereco.cep(cep)
    end
  end

  def test_should_raise_exception_when_invalid_code
    cep = "12345678"
    body = "&resultado=0&resultado_txt=servi%E7o+indispon%EDvel%2Fcep+inv%E1lido&uf=&cidade=&bairro=&tipo_logradouro=&logradouro="
    
    assert_raise RuntimeError, "CEP #{cep} não encontrado." do
      FakeWeb.register_uri(:get, "#{URL}#{cep}", :body => body)

      BuscaEndereco.cep("12345678")
    end
  end
end
