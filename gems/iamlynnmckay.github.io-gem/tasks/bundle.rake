# frozen_string_literal: true

namespace :bundle do
  desc 'Configure bundle. This sets the path for bundle gems to be installed in the vendor/bundle directory.'
  task :configure do
    sh 'bundle config set --local path \'vendor/bundle\''
  end

  desc 'Update bundle gems. This command updates all gems in the Gemfile to their latest versions.'
  task :update do
    sh 'bundle update'
  end

  desc 'Install bundle dependency gems. This command installs all gems listed in the Gemfile.'
  task :install do
    sh 'bundle install'
  end

  desc 'Run all bundle tasks. This runs all bundle tasks in sequence.'
  task all: %i[configure update install] do
  end
end
