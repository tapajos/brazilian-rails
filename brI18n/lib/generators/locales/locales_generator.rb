require "rails/generators"
module BrI18n
  module Generators
    class LocalesGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__) 
      desc = "Efetua uma cópia dos locales para a pasta do projeto, sendo assim possível criar suas customizações"
      
      def copy_files
        copy_file File.join(File.dirname(__FILE__),"../../locales/pt-BR.yml"), "config/locales/pt-BR.yml"
        copy_file File.join(File.dirname(__FILE__),"../../locales/devise.pt-BR.yml"), "config/locales/devise.pt-BR.yml"
      end
    end
  end
end
