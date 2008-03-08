module Inflector
  Inflector.inflections do |inflect|
    inflect.plural(/^([a-zA-z]*)r$/i, '\1res')
    inflect.plural(/^([a-zA-z]*)z$/i, '\1zes')
    
    inflect.plural(/^([a-zA-z]*)al$/i, '\1ais')
    inflect.plural(/^([a-zA-z]*)el$/i, '\1eis')
    inflect.plural(/^([a-zA-z]*)ol$/i, '\1ois')
    inflect.plural(/^([a-zA-z]*)ul$/i, '\1uis')

    inflect.plural(/^([a-zA-z]*)il$/i, '\1is')
    
    inflect.plural(/^([a-zA-z]*)m$/i, '\1ns')

    inflect.plural(/^([a-zA-z]*)([aeiou]s)$/i, '\1\2es')
    
    inflect.plural(/^([a-zA-z]*)ão$/i, '\1ões')
    inflect.plural(/^([a-zA-z]*)ao$/i, '\1oes')
    
    inflect.singular(/^([a-zA-z]*)as$/i, '\1a')
    inflect.singular(/^([a-zA-z]*)es$/i, '\1e')
    inflect.singular(/^([a-zA-z]*)is$/i, '\1i')
    inflect.singular(/^([a-zA-z]*)os$/i, '\1o')
    inflect.singular(/^([a-zA-z]*)us$/i, '\1u')

    inflect.singular(/^([a-zA-z]*)res$/i, '\1r')
    inflect.singular(/^([a-zA-z]*)zes$/i, '\1z')

    inflect.singular(/^([a-zA-z]*)ais$/i, '\1al')
    inflect.singular(/^([a-zA-z]*)eis$/i, '\1el')
    inflect.singular(/^([a-zA-z]*)ois$/i, '\1ol')
    inflect.singular(/^([a-zA-z]*)uis$/i, '\1ul')

    inflect.singular(/^([a-zA-z]*)ns$/i, '\1m')
    
    inflect.singular(/^([a-zA-z]*)ões$/i, '\1ão')
    inflect.singular(/^([a-zA-z]*)ães$/i, '\1ão')
    inflect.singular(/^([a-zA-z]*)ãos$/i, '\1ão')    
    inflect.singular(/^([a-zA-z]*)oes$/i, '\1ao')
    inflect.singular(/^([a-zA-z]*)aes$/i, '\1ao')
    inflect.singular(/^([a-zA-z]*)aos$/i, '\1ao')
    
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