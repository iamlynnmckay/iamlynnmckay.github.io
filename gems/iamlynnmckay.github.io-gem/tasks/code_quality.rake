# frozen_string_literal: true

namespace :code_quality do
  desc 'Run RuboCop with auto-corrections. RuboCop is a Ruby static code analyzer and formatter based on the community Ruby style guide.'
  task :rubocop do
    sh 'bundle exec rubocop --auto-correct'
  end

  desc 'Run Reek. Reek is a code smell detector for Ruby that identifies problematic code patterns.'
  task :reek do
    sh 'bundle exec reek'
  end

  desc 'Run Standard. Standard is a Ruby style guide, linter, and formatter that enforces a consistent coding style.'
  task :standard do
    sh 'bundle exec standardrb'
  end

  desc 'Run all code quality tasks. This runs all code quality tasks in sequence.'
  task all: %i[rubocop reek standard] do
  end
end
