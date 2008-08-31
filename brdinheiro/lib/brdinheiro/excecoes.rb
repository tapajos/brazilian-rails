def cria_excecao(classe, mensagem)
  eval "class #{classe}; def initialize; super('#{mensagem}'); end; end"
end
  
cria_excecao("DinheiroInvalidoError < ArgumentError", "O valor deve estar preenchido e no formato correto. Ex.: 100.00 .")
cria_excecao("DivisaPorNaoEscalarError < ArgumentError", "So eh possivel dividir dinheiro por numeros.")
