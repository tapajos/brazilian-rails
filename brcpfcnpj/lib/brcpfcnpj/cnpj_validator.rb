class CnpjValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    record.errors[attribute] << "nao e um CNPJ valido" unless Cnpj.new(value).valido?
  end
end