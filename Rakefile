require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :cops do
  sh 'rubocop'
  puts '-' * 50
  sh 'reek'
end
