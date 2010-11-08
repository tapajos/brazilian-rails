# encoding: UTF-8
require File.dirname(__FILE__) + "/test_helper"

class BrDinheiroTest < ActiveSupport::TestCase
  test "BrDinheiro should have a setup method" do
    assert BrDinheiro.respond_to?(:setup) 
  end

  test "setup method should yield self" do
    BrDinheiro.setup  do |config|
      assert_equal config, BrDinheiro
    end
  end

  test "BrDinheiro should have a configuration method called ativar_dinheiro" do
    assert BrDinheiro.methods.include?("ativar_dinheiro")
  end

  test "BrDinheiro should have a configuration method called ativar_activerecord_metodos" do
    assert BrDinheiro.methods.include?("ativar_activerecord_metodos")
  end
end
