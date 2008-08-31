require File.dirname(__FILE__) + '/test_helper'
require 'rubygems'
require 'net/http'
require 'mocha'


INVALID_ZIPS = [0, '0', '00', '000', '0000', '00000', '000000', '0000000', '00000000']
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
  def test_raise_witout_service
    http_response = MockServerError.new
    Net::HTTP.expects(:get_response).returns(http_response)
    assert_raise RuntimeError, "Não foi possível obter o cep. (505 - HTTPServiceUnaviable)" do
      BuscaEndereco.por_cep(VALID_ZIPS.first)
    end
  end

  def test_raise_for_invalid_zip_code
    INVALID_ZIPS.each do |invalid_zip|
      mock_get_response('invalid')
      assert_raise RuntimeError, "Cep #{invalid_zip} não encontrado." do
        BuscaEndereco.por_cep(invalid_zip)
      end
    end
  end

  def test_valid_code
    VALID_ZIPS.each do |valid_zip|
      mock_get_response(limpa_cep(valid_zip))
      assert_equal ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', limpa_cep(valid_zip)], BuscaEndereco.por_cep(valid_zip)
    end
  end

  private

  def mock_get_response(zip_number)
    xml_data = xml_data_from zip_name(zip_number)

    http_response = MockSuccess.new
    http_response.expects(:body).returns(xml_data)

    Net::HTTP.expects(:get_response).returns(http_response)
  end

  def xml_data_from xml_mock
    file = File.new(xml_mock)

    xml_data = ''

    while (line = file.gets)
      xml_data << line
    end

    xml_data
  end

  def zip_name(nome)
    File.join(File.dirname(__FILE__), 'mocks', "zip_#{nome}.xml")
  end
end

