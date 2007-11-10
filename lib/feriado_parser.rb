require 'find'
require 'yaml'
class FeriadoParser
  
  # Faz o parser do YML e retorna a coleção de feriados.
  def self.parser(diretorio)
    files = []
    feriados = []
    metodos = []
    raise FeriadoParserDiretorioInvalidoError unless File.directory?(diretorio)
    Find.find(diretorio) do |file| 
      files << file if file =~ /.*\.yml$/
    end
    raise FeriadoParserDiretorioVazioError if files.empty?
    files.each do |file|
      itens = YAML.load_file(file) 
      itens.each do |key, value|
        if value["metodo"]
          FeriadoParserMetodoInvalido if value["dia"] && value["mes"]
          metodos << value["metodo"]
        else
          feriados << Feriado.new(key, value["dia"], value["mes"])
        end
      end
    end
    [feriados, metodos]
  end
  
  
end
