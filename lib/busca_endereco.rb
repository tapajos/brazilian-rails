require 'net/http'
require 'rexml/document'

#Este recurso usa o webservice da http://www.bronzebusiness.com.br/webservices/wscep.asmx para
#realizar as consultas de cep, então, somente funcionará para serviços com acesso a internet e
#disponibilidade do serviço da Bronze Business.
# 
#Como fazer a busca de endereço por cep?
#
# BuscaEndereco.por_cep(22640010)     ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22640010')   ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22640-010')  ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('22.640-010') ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
# BuscaEndereco.por_cep('00000000')   ==> RuntimeError 'Cep 00000000 não encontrado.'
#
class BuscaEndereco

  URL_WEB_SERVICE = 'http://www.bronzebusiness.com.br/webservices/wscep.asmx/cep?strcep=' #:nodoc:
  
  # Retorna um array com os dados de endereçamento para o cep informado ou um erro para cep inexistente.
  #
  # Exemplo:
  #  BuscaEndereco.por_cep(22640010) ==> ['Avenida', 'das Americas', 'Barra da Tijuca', 'RJ', 'Rio de Janeiro', 22640100]
  def self.por_cep(numero)
    cep = numero.to_s.gsub(/\./, '').gsub(/\-/, '').to_i
    response = Net::HTTP.get_response(URI.parse("#{URL_WEB_SERVICE}#{cep}"))
    
    raise "Não foi possível obter o cep. (#{response.code} - #{response.message})" unless response.kind_of?(Net::HTTPSuccess)
    
    doc = REXML::Document.new(response.body)
    
    retorno = []
    %w(logradouro nome bairro UF cidade).each do |e|
      elemento = REXML::XPath.match(doc, "//#{e}").first
      raise "Cep #{cep} não encontrado." if elemento.nil?

      retorno << elemento.text
    end  
    
    retorno << cep
  end
end
