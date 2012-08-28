# encoding: UTF-8
require 'net/http'
require 'cgi'

# Este recurso tem como finalidade encontrar um endereço através de um CEP, e
# para isso ele utiliza o web service da Republica Virtual (http://cep.republicavirtual.com.br/web_cep.php)
# Obviamente, para utilizar este serviço é necessário uma conexão com a Internet.
#
# Como fazer a busca de endereço por cep?
#
# BuscaEndereco.cep(22640100)     ==> {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :uf => 'RJ', :cidade => 'Rio de Janeiro', :cep => '22640100'}
# BuscaEndereco.cep('22640100')   ==> {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :uf => 'RJ', :cidade => 'Rio de Janeiro', :cep => '22640100'}
# BuscaEndereco.cep('22640-100')  ==> {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :uf => 'RJ', :cidade => 'Rio de Janeiro', :cep => '22640100'}
# BuscaEndereco.cep('22.640-100') ==> {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :uf => 'RJ', :cidade => 'Rio de Janeiro', :cep => '22640100'}
#
# É feita uma validação para ver se o cep possui 8 caracteres após a remoção de '.' e '-'.
# BuscaEndereco.cep('0000000')   ==> RuntimeError 'O CEP informado possui um formato inválido.'
#
# Se necessário usar proxy, faça (de preferência em environment.rb):
# BuscaEndereco.proxy_addr= 'endereco.do.proxy'
# BuscaEndereco.proxy_port= 999 # porta a ser utilizada
#
class BuscaEndereco
  @@proxy_addr = nil
  @@proxy_port = nil

  class << self
    def proxy_addr
      @@proxy_addr
    end

    def proxy_addr=(addr)
      @@proxy_addr = addr
    end

    def proxy_port
      @@proxy_port
    end

    def proxy_port=(port)
      @@proxy_port = port
    end
  end

  WEB_SERVICE_REPUBLICA_VIRTUAL_URL = "http://cep.republicavirtual.com.br/web_cep.php?formato=query_string&cep="
  
  # Deprecated: Será removido
  def self.por_cep(numero)
    warn("DEPRECATION WARNING: O método `BuscaEnderedo.por_cep` será removido. Use o BuscaEndereco.cep e faça os ajustes necessarios")
    _cep = cep(numero)
    [
      _cep[:tipo_logradouro], 
      _cep[:logradouro], 
      _cep[:bairro], 
      _cep[:cidade], 
      _cep[:uf], 
      _cep[:cep]
    ]
  end

  # Retorna um hash com os dados de endereçamento para o cep informado ou 
  # um erro quando o serviço está indisponível, quando o cep informado possui 
  # um formato inválido ou quando o endereço não foi encontrado.
  #
  # Exemplo:
  #  BuscaEndereco.cep(22640100) ==> {:tipo_logradouro => 'Avenida', :logradouro => 'das Américas', :bairro => 'Barra da Tijuca', :uf => 'RJ', :cidade => 'Rio de Janeiro', :cep => '22640100'}
  def self.cep(numero)
    cep = numero.to_s.gsub(/[\.-]/, '')
    raise "O CEP informado possui um formato inválido." unless cep.to_s.match(/^\d{8}$/)
    
    response = Net::HTTP.Proxy(self.proxy_addr, self.proxy_port).get_response(URI.parse("#{WEB_SERVICE_REPUBLICA_VIRTUAL_URL}#{cep}"))
    raise "A busca de endereço por CEP através do web service da República Virtual está indisponível." unless response.kind_of?(Net::HTTPSuccess)

    doc = Hash[* CGI::parse(response.body).map {|k,v| [k,v[0]]}.flatten]
    
    retorno = {}
    
    raise "CEP #{cep} não encontrado." unless [1,2].include?(doc['resultado'].to_i)

    %w(tipo_logradouro logradouro bairro cidade uf).each do |field|
      retorno[field.to_sym] = if RUBY_VERSION < '1.9'
        require 'iconv'
        Iconv.conv("utf-8", "ISO-8859-1", doc[field])
      else 
        doc[field].force_encoding("ISO-8859-1").encode("UTF-8")
      end
    end

    retorno[:cep] = cep
    retorno
  end
end
