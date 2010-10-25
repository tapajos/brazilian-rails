# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

INVALID_ZIPS = [0, '0', '00', '000', '0000', '00000', '000000', '0000000', '00000000', '4006000']
VALID_ZIPS = [22640100, '22640100', '22.640100', '22640-100', '22.640-100']
VALID_ZIPS_WITH_ZERO_AT_BEGINNING = ['04006000', '04006-000', '04.006-000']
VALID_CEPS_NOT_FOUND_ON_BRONZE_BUSINESS = [20230024, '20230024', '20.230024', '20230-024', '20.230-024']
ZIPS_WITH_NO_ADDRESS_ASSOCIATED = [12345678, '12345678', '12.345678', '12345-678', '12.345-678']

class BuscaEnderecoTest < ActiveSupport::TestCase

  test "Raise without service on both web services" do
    http_error_response = MockServerError.new
  
    Net::HTTP.expects(:get_response).returns(http_error_response)
    Net::HTTP.expects(:get_response).returns(http_error_response)
  
    assert_raise RuntimeError, "A busca de endereço por CEP está indisponível no momento." do
      BuscaEndereco.por_cep(VALID_ZIPS.first)
    end
  end

  test "Raise for invalid zip code" do
    INVALID_ZIPS.each do |invalid_zip|
      assert_raise RuntimeError, "O CEP informado possui um formato inválido." do
        BuscaEndereco.por_cep(invalid_zip)
      end
    end
  end    
  
  test "Valid codes on bronze business" do
    VALID_ZIPS.each do |valid_zip|
      mock_get_response_from_bronze_business(limpa_cep(valid_zip))

      assert_equal ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro',
        limpa_cep(valid_zip)], BuscaEndereco.por_cep(valid_zip)
    end
  end

  test "Valid code with zero at beginning on bronze business" do
    VALID_ZIPS_WITH_ZERO_AT_BEGINNING.each do |valid_zip|
      mock_get_response_from_bronze_business(limpa_cep(valid_zip))

      assert_equal ['Rua', 'Doutor Tomaz Carvalhal', 'Paraiso', 'SP', 'Sao Paulo',
        limpa_cep(valid_zip)], BuscaEndereco.por_cep(valid_zip)
    end
  end

  test "Valid codes on buscar cep when bronze business is unavailable" do
    VALID_ZIPS.each do |valid_zip|
      mock_get_response_from_buscar_cep_when_bronze_business_is_unavailable(limpa_cep(valid_zip))

      assert_equal ['Avenida', 'das Américas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro',
        limpa_cep(valid_zip)], BuscaEndereco.por_cep(valid_zip)
    end
  end

  test "Valid codes on buscar cep when address not found on bronze business" do
    VALID_CEPS_NOT_FOUND_ON_BRONZE_BUSINESS.each do |cep_not_found_on_bronze_business|
      mock_get_response_from_buscar_cep_when_address_not_found_on_bronze_business(limpa_cep(cep_not_found_on_bronze_business))

      assert_equal ['Rua', 'Washington Luís', 'Centro', 'RJ', 'Rio de Janeiro', limpa_cep(cep_not_found_on_bronze_business)],
        BuscaEndereco.por_cep(cep_not_found_on_bronze_business)
    end
  end

  test "Should raise exception when search for zip with no associated address" do
    ZIPS_WITH_NO_ADDRESS_ASSOCIATED.each do |zip_with_no_address_associated|
      assert_raise RuntimeError, "CEP #{limpa_cep(zip_with_no_address_associated)} não encontrado." do
        mock_get_response_when_theres_no_address_associated_with_zip

        BuscaEndereco.por_cep(zip_with_no_address_associated)
      end
    end
  end

  private

  def mock_get_response_from_bronze_business(zip_number)
    xml_data = xml_data_from zip_name(zip_number, "bronze_business")

    http_success_response = MockSuccess.new
    http_success_response.expects(:body).returns(xml_data)

    Net::HTTP.expects(:get_response).returns(http_success_response)
  end

  def mock_get_response_from_buscar_cep_when_bronze_business_is_unavailable(zip_number)
    xml_data = xml_data_from zip_name(zip_number, "buscar_cep")

    http_success_response = MockSuccess.new
    http_success_response.expects(:body).returns(xml_data)

    Net::HTTP.expects(:get_response).returns(http_success_response)

    http_error_response = MockServerError.new
    Net::HTTP.expects(:get_response).returns(http_error_response)
  end

  def mock_get_response_from_buscar_cep_when_address_not_found_on_bronze_business(zip_number)
    xml_data_from_bronze_business = xml_data_from zip_name("not_found", "bronze_business")
    xml_data_from_buscar_cep = xml_data_from zip_name(zip_number, "buscar_cep")

    http_success_response_from_buscar_cep = MockSuccess.new
    http_success_response_from_buscar_cep.expects(:body).returns(xml_data_from_buscar_cep)
    Net::HTTP.expects(:get_response).returns(http_success_response_from_buscar_cep)

    http_success_response_from_bronze_business = MockSuccess.new
    http_success_response_from_bronze_business.expects(:body).returns(xml_data_from_bronze_business)
    Net::HTTP.expects(:get_response).returns(http_success_response_from_bronze_business)
  end

  def mock_get_response_when_theres_no_address_associated_with_zip
    xml_data_from_bronze_business = xml_data_from zip_name("not_found", "bronze_business")
    xml_data_from_buscar_cep = xml_data_from zip_name("not_found", "buscar_cep")

    http_success_response_from_buscar_cep = MockSuccess.new
    http_success_response_from_buscar_cep.expects(:body).returns(xml_data_from_buscar_cep)
    Net::HTTP.expects(:get_response).returns(http_success_response_from_buscar_cep)

    http_success_response_from_bronze_business = MockSuccess.new
    http_success_response_from_bronze_business.expects(:body).returns(xml_data_from_bronze_business)
    Net::HTTP.expects(:get_response).returns(http_success_response_from_bronze_business)
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
