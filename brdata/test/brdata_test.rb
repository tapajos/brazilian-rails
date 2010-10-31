# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class BrdataTest < ActiveSupport::TestCase
  test "BrData should have a method called setup" do
    assert_respond_to BrData, "setup"
  end

  test "BrData should yield self in setup" do
    BrData.setup do |config|
      assert_equal BrData, config
    end
  end

  test "BrData should have a configuration method called ativar_time" do
    assert BrData.methods.include?("ativar_time")  
  end

  test "BrData should have a configuration method called ativar_date" do
    assert BrData.methods.include?("ativar_date")  
  end

  test "BrData should have a configuration method called ativar_feriados" do
    assert BrData.methods.include?("ativar_feriados")  
  end
  
  test "BrData should have a configuration method called ativar_helpers" do
    assert BrData.methods.include?("ativar_helpers")  
  end
  
end
