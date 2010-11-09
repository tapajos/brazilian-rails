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

  test "Should have a method called proxy_address= and proxy_address" do
    assert_respond_to BrCep ,"proxy_address="
    assert_respond_to BrCep ,"proxy_address"
  end

  test "Should have a method called proxy_port= and proxy_port" do
    assert_respond_to BrCep ,"proxy_port="
    assert_respond_to BrCep ,"proxy_port"
  end
  
end
