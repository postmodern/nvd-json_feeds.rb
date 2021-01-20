# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'


require 'rubygems/tasks'
Gem::Tasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

namespace :spec do
  RSpec::Core::RakeTask.new(:integration) do |t|
    t.rspec_opts = '--tag integration'
  end
end

task :test    => [:spec, 'spec:integration']
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
task :doc => :yard
