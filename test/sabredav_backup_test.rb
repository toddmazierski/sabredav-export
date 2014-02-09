require 'test_helper'

class SabreDAVBackupTest < MiniTest::Unit::TestCase
  def test_config_present
    SabreDAVBackup.config do |config|
      config.username = 'admin'
    end

    assert_equal 'admin', SabreDAVBackup.username
  end

  def test_config_absent
    assert_raises(ArgumentError) { SabreDAVBackup.password }
  end
end
