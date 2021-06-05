require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "bump/tasks"

Bump.tag_by_default = true

RSpec::Core::RakeTask.new(:spec)

task default: :spec
