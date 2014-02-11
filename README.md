# sabredav_export

<a href='https://travis-ci.org/toddmazierski/sabredav-export'>
  <img src='https://api.travis-ci.org/toddmazierski/sabredav-export.png' />
</a>

<a href='https://codeclimate.com/github/toddmazierski/sabredav-export'>
  <img src='https://codeclimate.com/github/toddmazierski/sabredav-export.png' />
</a>

Saves remote [SabreDAV](http://sabredav.org/) calendars and address books to disk. Intended for use with the [Backup gem](http://meskyanichi.github.io/backup/v4/) (but it's not a requirement).

## Dependencies

  1. A SabreDAV server (tested with [Baïkal](http://baikal-server.com/))

  2. For calendar exports, the [iCalendar Export Plugin](http://sabredav.org/dav/ics-export-plugin/)

  3. For address book exports, the [vCard Export Plugin] (https://code.google.com/p/sabredav/wiki/VCFExportPlugin)

  4. Ruby (tested with 1.9.3 and 2.1)

  5. curl (for HTTP Digest Authentication)

## Installation

Please add this to your `Gemfile`:

```ruby
gem 'sabredav_export', :git => 'git@github.com:toddmazierski/sabredav-export.git', :ref => 'v0.0.2'
```

## Configuration

To configure, pass a block to `SabreDAVExport.config`:

```ruby
SabreDAVExport.config do |config|
  config.caldav_url  = 'https://example.com/cal.php'
  config.carddav_url = 'https://example.com/card.php'
  config.username    = 'admin'
  config.password    = 'swordfish'
end
```

Please note that the `username` in this context is for authentication purposes.

## Usage

```ruby
# Create a new instance.
address_book = SabreDAVExport::AddressBook.new('paul', 'geologists')
# => #<SabreDAVExport::AddressBook @name="geologists", @username="paul">

# Save the data to disk.
address_book.save
# => 27170

# Test the validity of the data.
address_book.test
# => true

# Here's the location on disk.
address_book.pathname
# => #<Pathname:/tmp/paul-geologists.vcard>

# Let's take a peek at the file.
address_book.pathname.open.lines.to_a[0..2]
# => ["BEGIN:VCARD\r\n",
#  "VERSION:3.0\r\n",
#  "PRODID:-//Apple Inc.//Address Book 6.1.2//EN\r\n"]

# Clean up what's saved to disk.
address_book.clean_up
# => 1
```

### In a Backup model

In this example:

  1. Resources are saved and tested in the `before` hook

  2. Each `pathname` is added to an archive

  3. Finally, what's saved to disk is cleaned up in the `after` hook

```ruby
Model.new(:baikal, 'Baïkal server backups') do
  resources = [
    SabreDAVExport::Calendar.new('paul', 'excavations'),
    SabreDAVExport::AddressBook.new('paul', 'geologists')
  ]

  before do
    resources.each(&:save)
    resources.each(&:test)
  end

  after { resources.each(&:clean_up) }

  archive :backups do |archive|
    resources.each do |resource|
      archive.add resource.pathname
    end
  end
end
```
