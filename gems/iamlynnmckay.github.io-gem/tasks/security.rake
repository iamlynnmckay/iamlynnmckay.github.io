# frozen_string_literal: true

namespace :security do
  desc 'Run Bundler Audit. Bundler Audit checks your Gemfile.lock for known security vulnerabilities in gems.'
  task :bundler_audit do
    sh 'bundle exec bundler-audit'
  end

  desc 'Run all security tasks. This runs all security tasks in sequence.'
  task all: [:bundler_audit] do
  end
end
