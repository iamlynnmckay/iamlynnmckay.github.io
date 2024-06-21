# frozen_string_literal: true

namespace :auto_correct do
  desc 'Run RuboCop with auto-correction and automatically generate a configuration file. RuboCop is a Ruby static code analyzer and formatter based on the community Ruby style guide.'
  task :rubocop do
    sh 'bundle exec rubocop --auto-correct --auto-gen-config'
  end

  desc 'Run all auto-correction tasks. This runs all auto-correction tasks in sequence.'
  task all: %i[rubocop] do
  end
end
