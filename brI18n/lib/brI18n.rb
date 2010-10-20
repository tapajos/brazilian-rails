$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

%w(version).each {|req| require File.dirname(__FILE__) + "/brI18n/#{req}"}

module BrI18n
  
  LOCALES = File.expand_path(File.dirname(__FILE__) + "/locales")
  
end

I18n.load_path += Dir.glob("#{BrI18n::LOCALES}/*")
I18n.default_locale = 'pt-BR'
