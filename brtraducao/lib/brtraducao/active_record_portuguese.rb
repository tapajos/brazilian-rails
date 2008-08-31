module ActiveRecord
  # Traduz as mensagens de erro do ActiveRecord::Errors
  #
  #    :inclusion => "não está incluído na lista"
  #    :exclusion => "é reservado"
  #    :invalid => "é inválido"
  #    :confirmation => "não corresponde à confirmação"
  #    :accepted  => "deve ser aceito"
  #    :empty => "deve ser preenchido"
  #    :blank => "deve ser preenchido"
  #    :too_long => "deve ter até %d caractere(s)"
  #    :too_short => "deve ter no mínimo %d caractere(s)"
  #    :wrong_length => "deve ter %d caractere(s)"
  #    :taken => "já está em uso"
  #    :not_a_number => "não é um número"
  #    :greater_than => "deve ser maior que %d"
  #    :greater_than_or_equal_to => "deve ser maior ou igual a %d"
  #    :equal_to => "deve ser igual a %d"
  #    :less_than => "deve ser menor que %d"
  #    :less_than_or_equal_to => "deve ser menor ou igual a %d"
  #    :odd => "deve ser impar"
  #    :even => "deve ser par"
  class Errors
    @@default_error_messages = {
      :inclusion => "não está incluído(a) na lista",
      :exclusion => "é reservado(a)",
      :invalid => "é inválido(a)",
      :confirmation => "não corresponde à confirmação",
      :accepted  => "deve ser aceito(a)",
      :empty => "deve ser preenchido(a)",
      :blank => "deve ser preenchido(a)",
      :too_long => "deve ter até %d caractere(s)",
      :too_short => "deve ter no mínimo %d caractere(s)",
      :wrong_length => "deve ter %d caractere(s)",
      :taken => "já está em uso",
      :not_a_number => "não é um número",
      :greater_than => "deve ser maior que %d",
      :greater_than_or_equal_to => "deve ser maior ou igual a %d",
      :equal_to => "deve ser igual a %d",
      :less_than => "deve ser menor que %d",
      :less_than_or_equal_to => "deve ser menor ou igual a %d",
      :odd => "deve ser impar",
      :even => "deve ser par"
    }
  end
  
end


