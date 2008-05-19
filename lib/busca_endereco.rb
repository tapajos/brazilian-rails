require 'net/http'
require 'rexml/document'

class BuscaEndereco

  URL_WEB_SERVICE = 'http://www.bronzebusiness.com.br/webservices/wscep.asmx/cep?strcep='
  
  def self.por_cep(numero)
    cep = numero.to_s.gsub(/\./, '').gsub(/\-/, '').to_i
    response = Net::HTTP.get_response(URI.parse("#{URL_WEB_SERVICE}#{cep}"))
    
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
