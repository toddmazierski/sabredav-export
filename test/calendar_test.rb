require 'test_helper'

class CalendarTest < MiniTest::Unit::TestCase
  def setup
    @caldav_url = 'https://example.com/cal.php'
    @auth_username = 'admin'
    @password = 'swordfish'
    SabreDAVBackup.stubs(:caldav_url).returns(@caldav_url)
    SabreDAVBackup.stubs(:username).returns(@auth_username)
    SabreDAVBackup.stubs(:password).returns(@password)

    @username = 'paul'
    @name = 'excavations'
    @calendar = SabreDAVBackup::Calendar.new(@username, @name)
  end

  def test_data
    expected_url = "#{@caldav_url}/calendars/#{@username}/#{@name}?export"
    expected_command = "curl #{expected_url} --digest --user #{@auth_username}:#{@password}"
    @calendar.expects(:`).with(expected_command)

    @calendar.data
  end
end
