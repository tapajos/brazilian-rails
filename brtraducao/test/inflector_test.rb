require File.dirname(__FILE__) + '/test_helper'
require 'yaml'

$KCODE = 'utf8'

def verify_pluralize(words)
  words.each do |key, value|
    module_eval %[
  def test_pluralize_#{key}_to_#{value}
    assert_equal '#{value}', '#{key}'.pluralize
  end
    ]
  end
end

def verify_singularize(words)
  words.each do |key, value|
    module_eval %[
  def test_singularize_#{value}_to_#{key}
    assert_equal '#{key}', '#{value}'.singularize
  end
    ]
  end
end

def verify_if_dont_pluralize(words)
  words.each do |key, value|
    module_eval %[
  def test_if_dont_pluralize_#{value}
    assert_equal '#{value}', '#{value}'.pluralize
  end
    ]
  end
end

def verify_if_dont_singularize(words)
  words.each do |key, value|
    module_eval %[
  def test_if_dont_singularize_#{key}
    assert_equal '#{key}', '#{key}'.singularize
  end
    ]
  end
end

class InflectorTest < Test::Unit::TestCase
  @words = YAML.load_file(File.dirname(__FILE__)+'/inflections.yaml') 

  verify_pluralize(@words)
  verify_singularize(@words)
  verify_if_dont_pluralize(@words)
  verify_if_dont_singularize(@words)

  def test_if_dont_pluralize
    %(sessoes).each do |value|
      assert_equal value, value.pluralize
    end
  end
end

