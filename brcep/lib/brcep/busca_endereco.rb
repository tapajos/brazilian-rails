require 'net/http'
require 'rexml/document'
require 'active_support'
require 'brstring'

#Este recurso usa o webservice da http://www.bronzebusiness.com.br/webservices/wscep.asmx para
#realizar as consultas de cep, então, somente funcionará para serviços com acesso a internet e
#disponibilidade do serviço da Bronze Business.
# 
#Como fazer a busca de endereço por cep?
#
# BuscaEndereco.por_cep(22640100)     ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22640100')   ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22640-100')  ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22.640-100') ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('00000000')   ==> RuntimeError 'Cep 00000000 não encontrado.'
# 
#Se necessário usar proxy, faça (de preferência em environment.rb):
# BuscaEndereco.proxy_addr= 'endereco.do.proxy'
# BuscaEndereco.proxy_port= 999 # porta a ser utilizada
#
class BuscaEndereco
  cattr_accessor :proxy_addr, :proxy_port

  URL_WEB_SERVICE_BRONZE_BUSINESS = 'http://www.bronzebusiness.com.br/webservices/wscep.asmx/cep?strcep=' #:nodoc:
  URL_WEB_SERVICE_BUSCAR_CEP = 'http://www.buscarcep.com.br/?cep=' #:nodoc:

  # Campos do XML retornado pelos web services
  CAMPOS_XML_BRONZE_BUSINESS = %w(logradouro nome bairro UF cidade) #:nodoc:
  CAMPOS_XML_BUSCAR_CEP = %w(tipo_logradouro logradouro bairro uf cidade) #:nodoc:
  
  # Retorna um array com os dados de endereçamento para o cep informado ou um erro para cep inexistente.
  #
  # Exemplo:
  #  BuscaEndereco.por_cep(22640100) ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
  def self.por_cep(numero)
    raise "O CEP informado possui um formato inválido." if numero.to_s.gsub(/\./, '').gsub(/\-/, '').length != 8

    @@cep = numero.to_s.gsub(/\./, '').gsub(/\-/, '').to_i

    @@retorno = []

    if web_service_da_bronze_business_esta_funcionando?
      usar_web_service_da_bronze_business
    elsif web_service_do_buscar_cep_esta_funcionando?
      usar_web_service_do_buscar_cep
    else
      raise "A busca de endereço por CEP está indisponível no momento."
    end
    
    @@retorno << @@cep
  end

  private
  def self.web_service_da_bronze_business_esta_funcionando?
    @@response = Net::HTTP.Proxy(self.proxy_addr, self.proxy_port).get_response(URI.parse("#{URL_WEB_SERVICE_BRONZE_BUSINESS}#{@@cep}"))
    @@response.kind_of?(Net::HTTPSuccess)
  end

  def self.usar_web_service_da_bronze_business
    @@doc = REXML::Document.new(@@response.body)
    processar_xml CAMPOS_XML_BRONZE_BUSINESS
  end

  def self.web_service_do_buscar_cep_esta_funcionando?
    @@response = Net::HTTP.Proxy(self.proxy_addr, self.proxy_port).get_response(URI.parse("#{URL_WEB_SERVICE_BUSCAR_CEP}#{@@cep}&formato=xml"))
    @@response.kind_of?(Net::HTTPSuccess)
  end

  def self.usar_web_service_do_buscar_cep
    @@doc = REXML::Document.new(@@response.body)
    processar_xml CAMPOS_XML_BUSCAR_CEP
  end

  def self.processar_xml(campos_do_xml)
    campos_do_xml.each do |e|
      elemento = REXML::XPath.match(@@doc, "//#{e}").first

      raise "Cep #{@@cep} não encontrado." if elemento.nil?

      # Remove os acentos já que o Buscar Cep retorna o endereço com acento e a Bronze Business não
      @@retorno << elemento.text.remover_acentos
    end
  end
end