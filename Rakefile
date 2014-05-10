# RSpec
require 'rspec/core/rake_task'
desc 'Run RSpec'
RSpec::Core::RakeTask.new(:spec)
task test: :spec

# Rubocop
begin
  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  Rubocop::RakeTask.new(:rubocop)do |task|
    task.fail_on_error = false
  end
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end

# Rake default
task default: [:spec, :rubocop]
