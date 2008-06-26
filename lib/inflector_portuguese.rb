# Infelizmente não é possível colocar todas as regras...
#
# http://pt.wikipedia.org/wiki/Plural e
# http://pt.wikipedia.org/wiki/Singular
module Inflector
  Inflector.inflections do |inflect|
    inflect.clear
    
    inflect.plural(/$/i,  's')
    inflect.plural(/s$/i,  's')
    inflect.plural(/(z|r)$/i, '\1es')
    inflect.plural(/al$/i,  'ais')
    inflect.plural(/el$/i,  'eis')
    inflect.plural(/ol$/i,  'ois')
    inflect.plural(/ul$/i,  'uis')
    inflect.plural(/([^aeou])il$/i,  '\1is')
    inflect.plural(/m$/i,   'ns')
    inflect.plural(/([^ê]s)$/i, '\1es')
    inflect.plural(/(ingl|dinamarqu|fregu|portugu)ês$/i,  '\1eses')
    inflect.plural(/ão$/i,  'ões')
    inflect.plural(/ao$/i,  'oes')
    inflect.plural(/ao$/i,  'oes')
    inflect.plural(/^(g|)ás$/i,  '\1ases')
    

    inflect.singular(/s$/i, '')
    inflect.singular(/(r|z)es$/i, '\1')
    inflect.singular(/ais$/i, 'al')
    inflect.singular(/eis$/i, 'el')
    inflect.singular(/ois$/i, 'ol')
    inflect.singular(/uis$/i, 'ul')
    inflect.singular(/([r|t])is$/i, '\1il')
    inflect.singular(/ns$/i, 'm')
    inflect.singular(/sses$/i, 'sse')
#    inflect.singular(/^(.*[^s]s)es$/i, '\1')
    inflect.singular(/ães$/i, 'ão')
    inflect.singular(/aes$/i, 'ao')
    inflect.singular(/ãos$/i, 'ão')    
    inflect.singular(/aos$/i, 'ao')
    inflect.singular(/ões$/i, 'ão')
    inflect.singular(/oes$/i, 'ao')
    inflect.singular(/(ingl|dinamarqu|fregu|portugu)eses$/i,  '\1ês')
    inflect.singular(/^(g|)ases$/i,  '\1ás')
    
    # #irregulares
    irregulares = {   'cão' => 'cães',
                      'pão' => 'pães',
                      'mão' => 'mãos',
                      'alemão' => 'alemães',
                      'cao' => 'caes',
                      'pao' => 'paes',
                      'mao' => 'maos',
                      'alemao' => 'alemaes',
                      }


    irregulares.each do |key, value|
      inflect.plural(/^#{key.to_s}$/, value)
      inflect.singular(/^#{value}$/, key.to_s)
    end
    
    inflect.uncountable %w( tórax tênis ônibus lápis fênix )
  end
end
