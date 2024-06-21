# frozen_string_literal: true

namespace :tasks do
  desc 'Run all setup tasks.'
  task setup: [
    'backup:all',
    'configure:all',
    'auto_correct:all'
  ] do
  end

  desc 'Run all pre-test tasks.'
  task pre_test: [
    'code_quality:all',
    'security:all',
    'performance:all'
  ] do
  end

  desc 'Run all test tasks.'
  task test: [
    'testing:all'
  ] do
  end

  desc 'Run all post-test tasks.'
  task post_test: [
    'documentation:all'
  ] do
  end

  desc 'Run all build tasks.'
  task build: [] do
    sh 'gem build *.gemspec'
  end

  task teardown: [
    'cleaning:all'
  ] do
  end
end
