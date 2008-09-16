# Representa um numero de CNPJ. Objetos da classe Cnpj recebem strings representando numeros de cnpj e verificam a validade destes numeros usando dois criterios:
# 1. O formato da string, que deve seguir o padrao xx.xxx.xxx/xxxx-xx, onde 'x' pode ser qualquer digito de 0 a 9 e os tracos (-), barra (/) e pontos (.) *sao opcionais*.
# 2. O conteudo numerico desta string, que eh validado atraves do calculo do 'modulo 11' dos digitos que compoe a string.
#
# Caso o conteudo da string obedeca ao formato especificado acima, o mesmo sera formatado para obedecer ao padrao xx.xxx.xxx/xxxx-xx
#
# Eh importante observar que caso voce associe um valor de cnpj invalido ao seu model, o mesmo passara automaticamente a ser invalido, o que impede que valores de cpf incorretos sejam salvos no banco de dados.
#
# Como usar a classe Cnpj no seu ActiveRecord:
#
# Suponha que temos um model Empresa, com um atributo 'cnpj'
# que voce quer usar como um numero de documento para cnpj. Basta usar o 
# metodo <tt>usar_como_cnpj</tt>, assim:
#
#   class Empresa < ActiveRecord::Base
#     usar_como_cnpj :cnpj
#   end
#
# Agora voce pode usar o atributo para cnpj da seguinte forma:
#
#  e = Empresa.new
#  e.cnpj = "69103604000160"
#  puts e.cnpj # ==> 69.103.604/0001-60
#  e.cnpj.valido? # ==> true
#  e.cnpj_valido? # ==> true
#   
#  e = Empresa.new(:cnpj => "69.103.604/0001-60")
#  puts e.cnpj # ==> 69.103.604/0001-60
#   
#  e = Empresa.new
#  e.cnpj = Cnpj.new("691036040001-60")
#  puts e.cnpj # ==> 69.103.604/0001-60
#
#  e = Empresa.new
#  e.cnpj = "12343" # ==> um cnpj invalido
#  puts e.valid? # ==> false
#  e.save # ==> false
#  e.errors.on(:cnpj) # ==> 'numero invalido'
#   
#  c = Cnpj.new("69103604000160")
#  e.cnpj = "69.103.604/0001-60"
#  c == e.cnpj # ==> true   
class Cnpj
  include CpfCnpj
end
