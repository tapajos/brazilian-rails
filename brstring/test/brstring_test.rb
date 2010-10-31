# encoding: UTF-8
require File.join(File.expand_path(File.dirname(__FILE__)), "test_helper.rb")

class BrstringTest < ActiveSupport::TestCase
  test "BrString should accept a configuration block" do
    assert BrString.respond_to?("setup") 
  end

  test "BrString configuration block should yield self" do
    BrString.setup do |config|
      assert_equal BrString, config
    end
  end

  test "BrString should have a private method ativar_brstring" do
    assert BrString.methods.include?("ativar_brstring") 
  end
end
