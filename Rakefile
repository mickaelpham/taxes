# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'reek/rake/task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new do |rubocop|
  rubocop.options       = ['--auto-correct']
  rubocop.fail_on_error = false
end

Reek::Rake::Task.new do |reek|
  reek.fail_on_error = false
end

task default: %i[reek rubocop spec]
