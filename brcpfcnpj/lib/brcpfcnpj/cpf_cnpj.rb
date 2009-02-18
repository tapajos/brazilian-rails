module CpfCnpj
  attr_reader :numero
  
  def initialize(numero)
    @numero = numero      
    @match = self.instance_of?(Cpf) ? @numero =~ CPF_REGEX : @numero =~ CNPJ_REGEX
    @numero_puro = $1
    @para_verificacao = $2
    @numero = (@match ? format_number! : nil)
  end
  
  def to_s
    @numero || ""
  end
  
  def ==(outro_doc)
    self.numero == outro_doc.numero
  end
  
  # Verifica se o numero possui o formato correto e se 
  # constitui um numero de documento valido, dependendo do seu
  # tipo (Cpf ou Cnpj).
  def valido?   
    return false unless @match    
    verifica_numero
  end  
  
  private
  DIVISOR = 11
  
  CPF_LENGTH = 11
  CPF_REGEX = /^(\d{3}\.?\d{3}\.?\d{3})-?(\d{2})$/
  CPF_ALGS_1 = [10, 9, 8, 7, 6, 5, 4, 3, 2]
  CPF_ALGS_2 = [11, 10, 9, 8, 7, 6, 5, 4, 3, 2]  
  
  CNPJ_LENGTH = 14  
  CNPJ_REGEX = /^(\d{2}\.?\d{3}\.?\d{3}\/?\d{4})-?(\d{2})$/ # <= 11.222.333/0001-XX
  CNPJ_ALGS_1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
  CNPJ_ALGS_2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2] 
  
  
  def verifica_numero    
    limpo = @numero.gsub(/[\.\/-]/, "")
    if self.instance_of? Cpf
      return false if limpo.length != 11
    elsif self.instance_of? Cnpj
      return false if limpo.length != 14
    end     
    return false if limpo.scan(/\d/).sort.join == limpo
    primeiro_verificador = primeiro_digito_verificador
    segundo_verificador = segundo_digito_verificador(primeiro_verificador)
    verif = primeiro_verificador + segundo_verificador
    verif == @para_verificacao
  end
  
  def multiplica_e_soma(algs, numero_str)
    multiplicados = []
    numero_str.scan(/\d{1}/).each_with_index { |e, i| multiplicados[i] = e.to_i * algs[i] } 
    multiplicados.inject { |s,e| s + e }    
  end
  
  def digito_verificador(resto)
    resto < 2 ? 0 : DIVISOR - resto
  end
  
  def primeiro_digito_verificador
    array = self.instance_of?(Cpf) ? CPF_ALGS_1 : CNPJ_ALGS_1    
    soma = multiplica_e_soma(array, @numero_puro)    
    digito_verificador(soma%DIVISOR).to_s
  end

  def segundo_digito_verificador(primeiro_verificador) 
    array = self.instance_of?(Cpf) ? CPF_ALGS_2 : CNPJ_ALGS_2   
    soma = multiplica_e_soma(array, @numero_puro + primeiro_verificador)    
    digito_verificador(soma%DIVISOR).to_s
  end
  
  def format_number!
    if self.instance_of? Cpf
      @numero =~ /(\d{3})\.?(\d{3})\.?(\d{3})-?(\d{2})/
      @numero = "#{$1}.#{$2}.#{$3}-#{$4}"
    else
      @numero =~ /(\d{2})\.?(\d{3})\.?(\d{3})\/?(\d{4})-?(\d{2})/    
      @numero = "#{$1}.#{$2}.#{$3}/#{$4}-#{$5}"  
    end    
  end  
  
end

