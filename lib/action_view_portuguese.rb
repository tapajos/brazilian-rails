module ActionView::Helpers::ActiveRecordHelper
  # Traduz as mensagens de erro do ActiveRecord
  def error_messages_for(*params)
    options = params.last.is_a?(Hash) ? params.pop.symbolize_keys : {}
    objects = params.collect { |object_name| instance_variable_get('@'+object_name.to_s()) }
    objects.compact!
    count   = objects.inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      html = {}
      [:id, :class].each do |key|
        if options.include?(key)
          value = options[key]
          html[key] = value unless value.blank?
        else
          html[key] = 'errorExplanation'
        end
      end
      header_message = "#{pluralize(count, 'erro')} para #{(options[:object_name] || params.first).to_s.gsub('_', ' ')}"
      error_messages = objects.map { |object| object.errors.full_messages.map {|msg| content_tag(:li, msg) } }
      content_tag(:div,
        content_tag(options[:header_tag] || :h2, header_message) <<
          content_tag(:p, 'Foram detectados os seguintes erros:') <<
          content_tag(:ul, error_messages),
        html
      )
    else
      ''
    end
  end
end

module ActionView::Helpers::DateHelper
  # Traduz o método distance_of_time_in_words para retornar esse valor em português
  #
  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = to_time.to_time if to_time.respond_to?(:to_time)
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round

    case distance_in_minutes
    when 0..1
      return (distance_in_minutes == 0) ? 'menos de um minuto' : '1 minuto' unless include_seconds
      case distance_in_seconds
      when 0..4   then 'menos de 5 segundos'
      when 5..9   then 'menos de 10 segundos'
      when 10..19 then 'menos de 20 segundos'
      when 20..39 then 'meio minuto'
      when 40..59 then 'menos de um minuto'
      else             '1 minuto'
      end

    when 2..44           then "#{distance_in_minutes} minutos"
    when 45..89          then 'aproximadamente 1 hora'
    when 90..1439        then "aproximadamente #{(distance_in_minutes.to_f / 60.0).round} horas"
    when 1440..2879      then '1 dia'
    when 2880..43199     then "#{(distance_in_minutes / 1440).round} dias"
    when 43200..86399    then 'aproximadamente 1 mês'
    when 86400..525959   then "#{(distance_in_minutes / 43200).round} meses"
    when 525960..1051919 then 'aproximadamente 1 ano'
    else                      "mais de #{(distance_in_minutes / 525960).round} anos"
    end
  end
end

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
  
  # Helper para montar um select para seleção de estados brasileiros, usando 
  # option_estados_for_select para gerar a lista de opções.
  def select_estado(object, method, options = {}, html_options = {})
    select object, method, ESTADOS_BRASILEIROS, options, html_options
  end
  
  # Helper para montar um select para seleção de estados brasileiros, usando 
  # option_uf_for_select para gerar a lista de opções.
  def select_uf(object, method, options = {}, html_options = {})
     select object, method, ESTADOS_BRASILEIROS.collect {|estado, sigla| sigla}, options, html_options
  end

  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição do nome do estado, mas armazenando a sigla.
  def option_estados_for_select
    html = ""
    html += options_for_select ESTADOS_BRASILEIROS
    html
  end
  
  # Retorna uma string com a lista de estados brasileiros para usar em uma tag select,
  # com exibição e armazenamento a sigla.
  def option_uf_for_select
    html = ""
    html += options_for_select ESTADOS_BRASILEIROS.collect {|nome,sigla| sigla}
    html
  end
end
