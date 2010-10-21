require File.join(File.expand_path(File.dirname(__FILE__)), "../test_helper.rb")

class LocalesGeneratorTest < Rails::Generators::TestCase
  tests BrI18n::Generators::LocalesGenerator
  destination File.expand_path(File.dirname(__FILE__), "tmp")
  setup :prepare_destination
  test "Verifica se o generator efetua a copia dos devidos arquivos de locale" do
    run_generator
    assert_file "config/locales/pt-BR.yml"
    assert_file "config/locales/devise.pt-BR.yml"
  end
end
