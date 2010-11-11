# encoding: UTF-8
require "test_helper"

class BrnumerosTest < ActiveSupport::TestCase
  test "BrNumeros should accept a configuration block" do
    assert BrNumeros.respond_to?("setup") 
  end

  test "BrNumeros should have a private method mensagem_zero_reais" do
    assert_respond_to BrNumeros, "mensagem_zero_reais=" 
  end

  test "BrNumeros setup method should yield self" do
    BrNumeros.setup do |config|
      assert_equal BrNumeros, config
    end
  end
end
