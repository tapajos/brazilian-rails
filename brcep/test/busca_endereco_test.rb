# encoding: UTF-8
require "test_helper.rb"

INVALID_ZIPS = [0, '0', '00', '000', '0000', '00000', '000000', '0000000', '4006000']
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

end
