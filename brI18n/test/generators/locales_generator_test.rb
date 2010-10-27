require File.join(File.expand_path(File.dirname(__FILE__)), "../test_helper.rb")

class LocalesGeneratorTest < Rails::Generators::TestCase
  tests BrI18n::Generators::LocalesGenerator
  destination File.expand_path(File.dirname(__FILE__), "tmp")
  setup :prepare_destination

  test "Verifica se o generator efetua a copia dos devidos arquivos de locale" do
    run_generator
    Dir.glob(File.join(File.dirname(File.expand_path(__FILE__)), "../../lib/locales/*.yml")).each do |file|
      assert_file "config/locales/#{File.split(file).last}"
    end
  end

end
