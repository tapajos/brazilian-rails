# encoding: UTF-8
module ActionView::Helpers::FormOptionsHelper
  ESTADOS_BRASILEIROS = [["Acre", "AC"],
    ["Alagoas", "AL"],
    ["Amapá", "AP"],
    ["Amazonas", "AM"],
    ["Bahia", "BA"],
    ["Ceará", "CE"],
    ["Distrito Federal", "DF"],
    ["Espírito Santos", "ES"],
    ["Goiás", "GO"],
    ["Maranhão", "MA"],
    ["Mato Grosso", "MT"],
    ["Mato Grosso do Sul", "MS"],
    ["Minas Gerais", "MG"],
    ["Pará", "PA"],
    ["Paraíba", "PB"],
    ["Paraná", "PR"],
    ["Pernambuco", "PE"],
    ["Piauí", "PI"],
    ["Rio de Janeiro", "RJ"], 
    ["Rio Grande do Norte", "RN"],
    ["Rio Grande do Sul", "RS"],
    ["Rondônia", "RO"],
    ["Roraima", "RR"],
    ["Santa Catarina", "SC"],
    ["São Paulo", "SP"],
    ["Sergipe", "SE"],
    ["Tocantins", "TO"]
  ] unless const_defined?("ESTADOS_BRASILEIROS")
  
  # Helper para montar um select para seleção de estados brasileiros por nome,
  # mas com armazenamento da sigla.
  def select_estado(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS, options, html_options
  end
  
  # Helper para montar um select para seleção de estados brasileiros por sigla.
  def select_uf(object, method, options = {}, html_options = {})
     select object, method, ESTADOS_BRASILEIROS.collect {|estado, sigla| sigla}, options, html_options
  end

  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição do nome do estado, mas armazenando a sigla.
  def option_estados_for_select
    options_for_select ESTADOS_BRASILEIROS
  end
  
  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição e armazenamento a sigla.
  def option_uf_for_select
    options_for_select ESTADOS_BRASILEIROS.collect {|nome,sigla| sigla}
  end
  
  # Helper para montar um select para seleção de sexo, armazenando apenas a 
  # inicial.
  def select_sexo(object, method, options = {}, html_options = {})
    select object, method, [['Masculino', 'M'], ['Feminino', 'F']], options, html_options
  end
end
