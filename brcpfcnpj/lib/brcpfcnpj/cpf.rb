# Representa um numero de CPF. Objetos da classe Cpf recebem strings representando
# numeros de cpf e verificam a validade destes numeros usando dois criterios:
# 1. O formato da string, que deve seguir o padrao xxx.xxx.xxx-xx, onde 'x' pode ser qualquer digito de 0 a 9 e os tracos (-) e pontos (.) *sao opcionais*.
# 2. O conteudo numerico desta string, que eh validado atraves do calculo do 'modulo 11' dos digitos que compoe a string.
#
# Caso o conteudo da string obedeca ao formato especificado acima, o mesmo sera formatado para obedecer ao padrao xxx.xxx.xxx-xx
#
# Eh importante observar que caso voce associe um valor de cpf invalido ao seu model, o mesmo passara automaticamente a ser invalido, o que impede que valores de cpf incorretos sejam salvos no banco de dados.
#
# Como usar a classe Cpf no seu ActiveRecord:
#
# Suponha que temos um model Pessoa, com um atributo 'cpf'
# que voce quer usar como um numero de documento para cpf. Basta usar o 
# metodo <tt>usar_como_cpf</tt>, assim:
#
#   class Pessoa < ActiveRecord::Base
#     usar_como_cpf :cpf
#   end
# 
# O atributo que sera usado como cpf pode ter qualquer nome e nao apenas 'cpf'
#
# Agora voce pode usar o atributo para cpf da seguinte forma:
# 
#   p = Pessoa.new
#   p.cpf = "11144477735"
#   puts p.cpf # ==> 111.444.777-35
#   p.cpf.valido? # ==> true
#   p.cpf_valido? # ==> true
#
#   p = Pessoa.new(:cpf => "111.444.777-35")
#   puts p.cpf # ==> 111.444.777-35
#
#   p = Pessoa.new
#   p.cpf = Cpf.new("111444777-35")
#   puts p.cpf # ==> 111.444.777-35
#
#   p = Pessoa.new
#   p.cpf = "12345" # ==> um cpf invalido
#   puts p.valid? # ==> false
#   p.save # ==> false
#   p.errors.on(:cpf) # ==> 'numero invalido'
#
#   c = Cpf.new("11144477735")
#   p.cpf = "111.444.777-35"
#   c == p.cpf # ==> true
# 
class Cpf 
  include CpfCnpj
end


