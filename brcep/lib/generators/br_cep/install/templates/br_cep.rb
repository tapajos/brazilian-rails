#########################################################################################
#   Arquivo de configuração do BrCep                                                    #
#   A gem não efetuará nenhuma modificação na sua aplicação sem antes ser descrito aqui.#
#########################################################################################

BrCep.setup do |config|
  
  #Caso precise de proxy basta habilitar as opções
  #config.proxy_address = "example.com"
  #config.proxy_port = 80

  #Define o retorno caso o formato do cep seja inválido
  #:throw lançará uma exception
  #:nil retornará nil
  config.cep_invalido = :throw

  #Define o retorno caso os serviços de busca estejam indisponíveis
  #:throw lançará uma exception
  #nil retornará nil
  config.servico_indisponivel = :throw
end

