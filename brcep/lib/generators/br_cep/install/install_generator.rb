module BrCep
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(File.expand_path(__FILE__)), "/templates/")  
      desc = "Efetua a cópia do arquivo de configuração para dentro da aplicação"       

      def copy_files
        copy_file "br_cep.rb", "config/br_cep.rb"
      end
      
    end
  end
end
