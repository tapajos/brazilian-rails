require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'net/http'
require 'mocha'

INVALID_ZIPS = [0, '0', '00', '000', '0000', '00000', '000000', '0000000']
VALID_ZIPS = [22640100, '22640100', '22.640-100', '22.640-100']

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
  numero.to_s.gsub(/\./, '').gsub(/\-/, '').to_i
end

class BuscaEnderecoTest < Test::Unit::TestCase
  def test_raise_without_service_on_both_web_services
    http_error_response = MockServerError.new
  
    Net::HTTP.expects(:get_response).returns(http_error_response)
    Net::HTTP.expects(:get_response).returns(http_error_response)
  
    assert_raise RuntimeError, "A busca de endereço por CEP está indisponível no momento." do
      BuscaEndereco.por_cep(VALID_ZIPS.first)
    end
  end

  def test_raise_for_invalid_zip_code
    INVALID_ZIPS.each do |invalid_zip|
      assert_raise RuntimeError, "O CEP informado possui um formato inválido." do
        BuscaEndereco.por_cep(invalid_zip)
      end
    end
  end    
  
  def test_valid_code_on_bronze_business
    VALID_ZIPS.each do |valid_zip|
      mock_get_response_from_bronze_business(limpa_cep(valid_zip))
      assert_equal ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro',
        limpa_cep(valid_zip)], BuscaEndereco.por_cep(valid_zip)
    end
  end

  def test_valid_code_on_buscar_cep
    mock_get_response_from_buscar_cep(limpa_cep(VALID_ZIPS.first))
    assert_equal ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro',
      limpa_cep(VALID_ZIPS.first)], BuscaEndereco.por_cep(VALID_ZIPS.first)
  end

  def test_should_return_the_same_address_on_both_web_services
    mock_get_response_from_bronze_business(limpa_cep(VALID_ZIPS.first))
    mock_get_response_from_buscar_cep(limpa_cep(VALID_ZIPS.first))
    assert_equal  BuscaEndereco.por_cep(VALID_ZIPS.first), BuscaEndereco.por_cep(VALID_ZIPS.first)
  end

  private

  def mock_get_response_from_bronze_business(zip_number)
    xml_data = xml_data_from zip_name(zip_number, "bronze_business")

    http_response = MockSuccess.new
    http_response.expects(:body).returns(xml_data)

    Net::HTTP.expects(:get_response).returns(http_response)
  end

  def mock_get_response_from_buscar_cep(zip_number)
    xml_data = xml_data_from zip_name(zip_number, "buscar_cep")

    http_success_response = MockSuccess.new
    http_success_response.expects(:body).returns(xml_data)

    Net::HTTP.expects(:get_response).returns(http_success_response)

    http_error_response = MockServerError.new
    Net::HTTP.expects(:get_response).returns(http_error_response)
  end

  def xml_data_from xml_mock
    file = File.new(xml_mock)

    xml_data = ''

    while (line = file.gets)
      xml_data << line
    end

    xml_data
  end

  def zip_name(nome, web_service)
    File.join(File.dirname(__FILE__), 'mocks', "zip_#{nome}_#{web_service}.xml")
  end
end