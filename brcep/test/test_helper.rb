ENV["RAILS_ENV"] = "test"

require 'rubygems'
require "rails"
require 'rails/test_help'
require 'net/http'
require 'mocha'
require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/brcep.rb")
require File.join(File.dirname(File.expand_path(__FILE__)), "../lib/generators/br_cep/install/install_generator.rb")

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

