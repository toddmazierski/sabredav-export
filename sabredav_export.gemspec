Gem::Specification.new do |spec|
  spec.name         = 'sabredav_export'
  spec.version      = '0.0.2'
  spec.date         = '2014-02-10'
  spec.summary      = 'Saves remote SabreDAV calendars and address books to disk.'
  spec.authors      = ['Todd Mazierski']
  spec.email        = 'todd@paperlesspost.com'
  spec.files        = Dir.glob('lib/**/*')
  spec.homepage     = 'https://github.com/toddmazierski/sabredav-export'
  spec.license      = 'MIT'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'mocha'
end
