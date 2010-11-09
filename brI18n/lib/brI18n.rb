require "brI18n/version"

module BrI18n
  
  LOCALES_PATH = File.expand_path(File.dirname(__FILE__) + "/locales")

  def self.setup
    yield self
  end

  private
  def self.ativar_traducoes(*args)
    I18n.default_locale = 'pt-BR'
    
    if args.empty?
      I18n.load_path += Dir.glob("#{BrI18n::LOCALES_PATH}/*.pt-BR.yml")
    else
      args.each do |arg|
        I18n.load_path << "#{BrI18n::LOCALES_PATH}/#{arg}.pt-BR.yml"
      end
    end
  end

end



