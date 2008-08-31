module ActionView::Helpers::FormHelper
  
  # Helper para seleção de sexo com radio_buttom.
  def radio_button_sexo(object, method, options_radio_male = {}, options_radio_female = {})
    options_male = { }.update(options_radio_male.stringify_keys)
    options_female = {  }.update(options_radio_female.stringify_keys)
    
    op1= radio_button(object, method, 'M', options_male)
    op2 = radio_button(object, method, 'F', options_female)
    
    "#{op1} Masculino\n#{op2} Feminino"
  end  
end