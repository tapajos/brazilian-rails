# encoding: UTF-8
require File.dirname(__FILE__) + "/test_helper"

class BrI18nTest < ActiveSupport::TestCase


  def setup
    I18n.load_path = []
    BrI18n.setup do |config|
      config.ativar_traducoes
    end
  end

  test "brI18n deve aceitar um bloco de configuração" do
    BrI18n.setup do |config|
      assert_equal BrI18n, config
    end
  end

  test "Verifica se default_locale é igual a pt-BR" do
    assert_equal I18n.default_locale.to_s, "pt-BR"
  end

  test "ativar_locales deve incluir todos arquivos se chamado sem parâmetros" do
    BrI18n.setup do |config|
      config.ativar_traducoes
    end

    Dir.glob("#{BrI18n::LOCALES_PATH}/*").each do |file|
      assert I18n.load_path.include?(file)
    end
  end

  test "ativar_locales deve incluir apenas arquivos selecionados se chamado com parâmetros" do
    I18n.load_path = []
    
    BrI18n.setup do |config|
      config.ativar_traducoes :rails
    end
    assert_equal I18n.load_path.count, 1
    assert_equal I18n.load_path.first, "#{BrI18n::LOCALES_PATH}/rails.pt-BR.yml"

    I18n.load_path = []

    BrI18n.setup do |config|
      config.ativar_traducoes :devise
    end

    assert_equal I18n.load_path.count, 1
    assert_equal I18n.load_path.first, "#{BrI18n::LOCALES_PATH}/devise.pt-BR.yml"
  end

end
