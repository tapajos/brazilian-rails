# encoding: UTF-8
def cria_excecao(classe, mensagem)
  eval "class #{classe}; def initialize; super('#{mensagem}'); end; end"
end
  
cria_excecao("FeriadoMesInvalidoError < ArgumentError", "O mês deve ser um número e estar entre 01 e 12")
cria_excecao("FeriadoDiaInvalidoError < ArgumentError", "O mês deve ser um número e estar entre 01 e 31")
cria_excecao("FeriadoParserDiretorioInvalidoError < ArgumentError", "Só é possivel fazer parser de um diretorio contendo os arquivos yml.")
cria_excecao("FeriadoParserDiretorioVazioError < ArgumentError", "Não existe nenhum yml no diretorio.")
cria_excecao("FeriadoParserMetodoInvalido < ArgumentError", "Quando for usado o parametro metodo não deve exitir dia nem mês.")

