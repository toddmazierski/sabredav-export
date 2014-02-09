require 'rake/testtask'

Rake::TestTask.new do |task|
  task.pattern = 'test/*_test.rb'
  task.libs << 'test'
end

task :default => :test
