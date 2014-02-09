require 'test_helper'

class BaseResourceTest < MiniTest::Unit::TestCase
  def setup
    @resource = SabreDAVBackup::BaseResource.new(mock, mock)
  end

  def test_save
    data = mock
    @resource.expects(:data).returns(data)

    file = mock
    file.expects(:write).with(data)

    pathname = mock
    pathname.expects(:open).with('w').yields(file)
    @resource.expects(:pathname).returns(pathname)

    @resource.save
  end

  def test_test_successful
    header_1 = mock
    header_2 = header_1
    @resource.expects(:expected_header).returns(header_1)
    @resource.expects(:actual_header).returns(header_2)

    assert @resource.test
  end

  def test_test_failed
    header_1 = mock
    header_2 = mock
    @resource.expects(:expected_header).at_least_once.returns(header_1)
    @resource.expects(:actual_header).at_least_once.returns(header_2)

    expected_exception = SabreDAVBackup::BaseResource::UnexpectedHeader
    assert_raises(expected_exception) { @resource.test }
  end

  def test_pathname
    filename = 'excavations.ics'
    @resource.expects(:filename).returns(filename)

    expected_pathname = "#{Dir.tmpdir}/#{filename}"
    assert_equal expected_pathname, @resource.pathname.to_s
  end

  def test_clean_up_present
    pathname = mock
    pathname.expects(:exist?).returns(true)
    pathname.expects(:delete)
    @resource.expects(:pathname).at_least_once.returns(pathname)

    @resource.clean_up
  end

  def test_clean_up_absent
    pathname = mock
    pathname.expects(:exist?).returns(false)
    pathname.expects(:delete).never
    @resource.expects(:pathname).returns(pathname)

    @resource.clean_up
  end
end
