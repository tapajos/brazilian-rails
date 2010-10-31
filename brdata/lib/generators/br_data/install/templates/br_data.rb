#########################################################################################
#   Arquivo de configuração do BrData                                                   #
#   A gem não efetuará nenhuma modificação na sua aplicação sem antes ser descrito aqui.#
#########################################################################################

BrData.setup do |config|

  #Ativa os métodos da class Date
  config.ativar_date

  #Ativa os métodos da class Time
  config.ativar_time

  #Ativa os helpers para as views
  config.ativar_helpers

  #Ativa a capaciade de verificar se uma data é feriado
  config.ativar_feriados
end

