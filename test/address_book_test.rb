require 'test_helper'

class AddressBookTest < MiniTest::Unit::TestCase
  def setup
    @carddav_url = 'https://example.com/card.php'
    @auth_username = 'admin'
    @password = 'swordfish'
    SabreDAVExport.stubs(:carddav_url).returns(@carddav_url)
    SabreDAVExport.stubs(:username).returns(@auth_username)
    SabreDAVExport.stubs(:password).returns(@password)

    @username = 'paul'
    @name = 'geologists'
    @address_book = SabreDAVExport::AddressBook.new(@username, @name)
  end

  def test_data
    expected_url = "#{@carddav_url}/addressbooks/#{@username}/#{@name}?export"
    expected_command = "curl #{expected_url} --digest --user #{@auth_username}:#{@password}"
    @address_book.expects(:`).with(expected_command)

    @address_book.data
  end
end
