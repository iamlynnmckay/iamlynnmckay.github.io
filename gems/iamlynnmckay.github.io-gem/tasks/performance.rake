# frozen_string_literal: true

namespace :performance do
  desc 'Run Fasterer. Fasterer checks for Ruby code patterns that can be optimized for performance improvements.'
  task :fasterer do
    sh 'bundle exec fasterer'
  end

  desc 'Run RuboCop Performance with auto-corrections but do not ignore errors. This runs RuboCop with performance-related cops and applies automatic corrections where possible.'
  task :rubocop_performance do
    sh 'bundle exec rubocop -A --require rubocop-performance'
  end

  desc 'Run all performance tasks. This runs all performance tasks in sequence.'
  task all: %i[fasterer rubocop_performance] do
  end
end
