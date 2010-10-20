# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")
class BrI18nTest < ActiveSupport::TestCase

  test "Verifica se default_locale é igual a pt-BR" do
    assert_equal I18n.default_locale.to_s, "pt-BR"
  end

  test "Verifica se I18n.load_path inclui os arquivos de tradução do brI18n" do
    Dir.glob("#{BrI18n::I18N_FILES}/*").each do |file|
      assert I18n.load_path.include?(file)
    end
  end
end
