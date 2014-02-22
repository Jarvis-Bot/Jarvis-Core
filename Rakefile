# RSpec
require 'rspec/core/rake_task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new(:spec)
task :test => :spec


# Rubocop
require 'rubocop/rake_task'
desc 'Run RuboCop'
Rubocop::RakeTask.new(:rubocop)do |task|
  task.fail_on_error = false
end



# Rake default
task :default => [:spec, :rubocop]
