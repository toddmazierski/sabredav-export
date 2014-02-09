class SabreDAVBackup
  class AddressBook < BaseResource
  private

    def filename
      "#{@username}-#{@name}.vcard"
    end

    def url
      File.join(SabreDAVBackup.carddav_url + "/addressbooks/#{@username}/#{@name}?export")
    end

    def expected_header
      'BEGIN:VCARD'
    end
  end
end
