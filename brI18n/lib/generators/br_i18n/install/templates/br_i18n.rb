#########################################################################################
#   Arquivo de configuração do BrI18n                                                   #
#   A gem não efetuará nenhuma modificação na sua aplicação sem antes ser descrito aqui.#
#########################################################################################

BrI18n.setup do |config|

  #Usa pt-BR como o default-locale da aplicação
  #Carrega todos os locales de traduções disponíveis na gem
  #Atualmente: rails.pt-Br e devise.pt-BR são as traduçõs suportadas
  #Esse método também pode receber como parâmetro quais traduções deseja carregar, como :rails ou :devise
  config.ativar_locales

end
