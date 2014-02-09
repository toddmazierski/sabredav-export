class SabreDAVBackup
  class BaseResource
    class UnexpectedHeader < StandardError; end

    TEMP_PATHNAME = Pathname.new(Dir.tmpdir)

    # Returns a new resource instance for the given +username+ and resource
    # +name+.
    def initialize(username, name)
      @username = username
      @name = name
    end

    # Saves the resource data to disk.
    def save
      pathname.open('w') { |file| file.write(data) }
    end

    # Tests the validity of the resource data. Raises an exception if invalid.
    def test
      return true if expected_header == actual_header

      message = "expected #{expected_header.inspect}, got #{actual_header.inspect}"
      raise(UnexpectedHeader, message)
    end

    # Returns a pathname for the resource data on disk.
    def pathname
      @pathname ||= TEMP_PATHNAME + filename
    end

    # Cleans up resource data saved to disk, if present.
    def clean_up
      pathname.delete if pathname.exist?
    end

    # Returns the resource data.
    def data
      @data ||= `curl #{url} --digest --user #{username}:#{password}`
    end

  private

    # Returns a shell-escaped copy of the username for authentication.
    def username
      Shellwords.shellescape(SabreDAVBackup.username)
    end

    # Returns a shell-escaped copy of the password for authentication.
    def password
      Shellwords.shellescape(SabreDAVBackup.password)
    end

    # Returns the header (i.e. the first line) of the resource data.
    def actual_header
      data.lines.first.chomp
    end

    # Returns a filename for the resource on disk.
    #
    # Intended to be overridden when inherited from.
    def filename
      raise
    end

    # The remote URL from which to fetch the resource data.
    #
    # Intended to be overridden when inherited from.
    def url
      raise
    end

    # The expected header of the resource data.
    #
    # Intended to be overridden when inherited from.
    def expected_header
      raise
    end
  end
end
