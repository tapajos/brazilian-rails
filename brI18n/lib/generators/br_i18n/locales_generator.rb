require "rails/generators"
module BrI18n
  module Generators
    class LocalesGenerator < Rails::Generators::Base
      source_root File.join(File.dirname(File.expand_path(__FILE__)), "../../locales/")  
      desc = "Efetua uma cópia dos locales para a pasta do projeto, sendo assim possível criar suas customizações"
      
      def copy_files
        copy_file "rails.pt-BR.yml", "config/locales/rails.pt-BR.yml"
        copy_file "devise.pt-BR.yml", "config/locales/devise.pt-BR.yml"
      end
    end
  end
end
