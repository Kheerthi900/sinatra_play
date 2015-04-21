require 'rake'
require 'pry'
require 'rake/testtask'

Dir.glob('lib/tasks/*.rake').each { |r| load r}

Dir[File.join('lib', 'tasks', '**', '*.rake')].each do |file|
  import file
end

task :console do
  binding.pry
end

namespace :db do
  desc 'Load db config'
  task :load_config do
    require './app'
    puts 'hi, load_config'
  end
end

task :default => :test

desc "Run all tests"
task(:test) do
  Dir['./spec/**/*_spec.rb'].each { |f| load f }
end
