require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task(:spec).clear
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end
task(:default).prerequisites << task(:spec)

RuboCop::RakeTask.new
task(:default).prerequisites << task(:rubocop)
