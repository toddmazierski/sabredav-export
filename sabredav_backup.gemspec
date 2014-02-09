Gem::Specification.new do |spec|
  spec.name         = 'sabredav_backup'
  spec.version      = '0.0.1'
  spec.date         = '2014-02-09'
  spec.summary      = 'Saves remote SabreDAV calendars and address books to disk.'
  spec.authors      = ['Todd Mazierski']
  spec.email        = 'todd@paperlesspost.com'
  spec.files        = Dir.glob('lib/**/*')
  spec.homepage     = 'http://rubygems.org/gems/sabredav_backup'
  spec.license      = 'MIT'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'mocha'
end
