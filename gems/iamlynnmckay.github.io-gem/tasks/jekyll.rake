# frozen_string_literal: true

namespace :jekyll do
  desc 'Build the Jekyll site. This command builds the Jekyll site into the _site directory and provides detailed error tracing.'
  task :build do
    sh 'bundle exec jekyll build --trace'
  end

  desc 'Serve the Jekyll site with trace output. This command runs Jekyll\'s built-in web server and provides detailed error tracing.'
  task :serve do
    # TODO: this terminates the process immediately and does not serve the site
    sh 'bundle exec jekyll serve --trace --watch'
  end

  desc 'Run all Jekyll tasks. This runs all Jekyll tasks in sequence.'
  task all: %i[build serve] do
  end
end
