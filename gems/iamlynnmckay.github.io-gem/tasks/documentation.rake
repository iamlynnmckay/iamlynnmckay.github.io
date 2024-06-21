# frozen_string_literal: true

namespace :documentation do
  desc 'Generate documentation using YARD. YARD is a Ruby documentation tool that generates API documentation for Ruby projects.'
  task :yard do
    sh 'bundle exec yard doc'
  end

  desc 'Run all documentation tasks. This runs all documentation tasks in sequence.'
  task all: [:yard] do
  end
end
