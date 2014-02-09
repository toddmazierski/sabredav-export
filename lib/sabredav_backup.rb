require 'tmpdir'
require 'shellwords'
require 'pathname'

class SabreDAVBackup
  class << self
    ATTRIBUTES = :username,
                 :password,
                 :caldav_url,
                 :carddav_url

    attr_accessor *ATTRIBUTES

    # Yields to the given +block+ to assign configuration values.
    def config(&block)
      yield(self)
    end

    ATTRIBUTES.each do |attribute|
      # Returns an assigned configuration value. Raises an exception if missing.
      define_method(attribute) do
        value = instance_variable_get("@#{attribute}")
        return value if value

        raise(ArgumentError, "missing configuration value: #{attribute}")
      end
    end
  end
end

require 'sabredav_backup/base_resource'
require 'sabredav_backup/address_book'
require 'sabredav_backup/calendar'
