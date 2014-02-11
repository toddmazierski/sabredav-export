require 'test_helper'

class SabreDAVExportTest < MiniTest::Unit::TestCase
  def test_config_present
    SabreDAVExport.config do |config|
      config.username = 'admin'
    end

    assert_equal 'admin', SabreDAVExport.username
  end

  def test_config_absent
    assert_raises(ArgumentError) { SabreDAVExport.password }
  end
end
