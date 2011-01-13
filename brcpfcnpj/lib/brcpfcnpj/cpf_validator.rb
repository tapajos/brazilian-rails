class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    record.errors[attribute] << "nao e um CPF valido" unless Cpf.new(value).valido?
  end
end