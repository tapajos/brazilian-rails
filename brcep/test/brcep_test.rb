# encoding: UTF-8
require "test_helper.rb"

class BrcepTest < ActiveSupport::TestCase

  test "BrCep should accept a configuration block" do
    assert BrCep.respond_to?("setup") 
  end 

  test "Assert the block yields self" do
    BrCep.setup do |config|
      assert_equal config, BrCep
    end
  end

  test "Should raise if ativar_busca_endereco is not called" do
    assert_raise NameError  do
      BuscaEndereco
    end
  end

end
