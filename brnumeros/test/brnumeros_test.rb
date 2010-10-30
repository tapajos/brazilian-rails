# encoding: UTF-8
require File.join(File.dirname(File.expand_path(__FILE__)), "test_helper.rb")

class BrnumerosTest < ActiveSupport::TestCase
  test "BrNumeros should accept a configuration block" do
    assert BrNumeros.respond_to?("setup") 
  end

  test "BrNumeros should have a private method ativar_numeros_extensos" do
    assert BrNumeros.methods.include?("ativar_numeros_extensos") 
  end

  test "BrNumeros should have a private method mensagem_zero_reais" do
    assert BrNumeros.methods.include?("mensagem_zero_reais=") 
  end

  test "BrNumeros setup method should yield self" do
    BrNumeros.setup do |config|
      assert_equal BrNumeros, config
    end
  end
end
