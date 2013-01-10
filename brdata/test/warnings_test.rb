require 'test/unit'
require 'stringio'

class WarningsTest < Test::Unit::TestCase
  def setup
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  def teardown
    $stderr = @old_stderr
  end

  def test_to_show_warnings_if_app_path_is_defined
    Object.const_set(:APP_PATH, 'true')
    require File.dirname(__FILE__) + '/../lib/brdata.rb'

    warnings = $stderr.string.split(/\n/)
    warnings.each { |w| assert_no_match(/warning: already initialized constant/, w) }
  end
end
