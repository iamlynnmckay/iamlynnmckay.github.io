# frozen_string_literal: true

namespace :testing do
  desc 'Run RSpec tests. This command executes RSpec to run your test suite and report results.'
  task :rspec do
    sh 'bundle exec rspec'
  end

  desc 'Run all testing tasks. This runs all testing tasks in sequence.'
  task all: [:rspec] do
  end
end
