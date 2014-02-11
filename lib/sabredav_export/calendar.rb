class SabreDAVExport
  class Calendar < BaseResource
  private

    def filename
      "#{@username}-#{@name}.ics"
    end

    def url
      File.join(SabreDAVExport.caldav_url + "/calendars/#{@username}/#{@name}?export")
    end

    def expected_header
      'BEGIN:VCALENDAR'
    end
  end
end
