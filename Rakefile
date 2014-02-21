# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :test => :spec


# Rubocop
begin
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end



# Rake default
task :default => [:spec, :rubocop]
