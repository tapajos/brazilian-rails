#########################################################################################
#   Arquivo de configuração do BrCep                                                    #
#   A gem não efetuará nenhuma modificação na sua aplicação sem antes ser descrito aqui.#
#########################################################################################

BrCep.setup do |config|

  #Opção que ativa a class BuscaEndereço
  #Em qualquer parte da sua aplicação será possível fazer: BuscaEndereco.por_cep(15500-000)
  config.ativar_busca_endereco

end

