module Inflector
  Inflector.inflections do |inflect|
    inflect.singular(/^(.*)s$/i, '\1')
    inflect.singular(/^(.*)s$/i, '\1')
    inflect.singular(/^(.*)s$/i, '\1')
    inflect.singular(/^(.*)s$/i, '\1')
    inflect.singular(/^(.*)s$/i, '\1')

    inflect.plural(/^(.*[z|r])$/i, '\1es')
    inflect.singular(/^(.*[r|z])es$/i, '\1')
    
    inflect.plural(/^(.*)al$/i, '\1ais')
    inflect.plural(/^(.*)el$/i, '\1eis')
    inflect.plural(/^(.*)ol$/i, '\1ois')
    inflect.plural(/^(.*)ul$/i, '\1uis')
    inflect.singular(/^(.*)ais$/i, '\1al')
    inflect.singular(/^(.*)eis$/i, '\1el')
    inflect.singular(/^(.*)ois$/i, '\1ol')
    inflect.singular(/^(.*)uis$/i, '\1ul')

    inflect.plural(/^(.*)il$/i, '\1is')
    
    inflect.plural(/^(.*)m$/i, '\1ns')
    inflect.singular(/^(.*)ns$/i, '\1m')

    inflect.plural(/^(.*s)$/i, '\1es')
    inflect.singular(/^(.*s)es$/i, '\1')
    
    inflect.plural(/^(.*)ão$/i, '\1ões')
    inflect.singular(/^(.*)ões$/i, '\1ão')

    inflect.plural(/^(.*)ao$/i, '\1oes')
    inflect.singular(/^(.*)aos$/i, '\1ao')
    
    inflect.singular(/^(.*)ães$/i, '\1ão')
    inflect.singular(/^(.*)ãos$/i, '\1ão')    
    inflect.singular(/^(.*)oes$/i, '\1ao')
    inflect.singular(/^(.*)aes$/i, '\1ao')
    
    #irregulares
    irregulares = {
                   :cão => 'cães', 
                   :pão => 'pães',
                   :mão => 'mãos',
                   :alemão => 'alemães',
                   :cao => 'caes', 
                   :pao => 'paes',
                   :mao => 'maos',
                   :alemao => 'alemaes',
                   :mail => 'mails',
                   :email => 'emails'
                   }
                   
    irregulares.each do |key, value|
      inflect.plural(/^#{key.to_s}$/, value)
      inflect.singular(/^#{value}$/, key.to_s)
    end
    
    inflect.uncountable %w( tennis torax )
  end
end