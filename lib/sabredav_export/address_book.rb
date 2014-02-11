class SabreDAVExport
  class AddressBook < BaseResource
  private

    def filename
      "#{@username}-#{@name}.vcard"
    end

    def url
      File.join(SabreDAVExport.carddav_url + "/addressbooks/#{@username}/#{@name}?export")
    end

    def expected_header
      'BEGIN:VCARD'
    end
  end
end
