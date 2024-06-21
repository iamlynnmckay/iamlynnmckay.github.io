# frozen_string_literal: true

namespace :build do
  desc 'Run all tasks for the release build.'
  task release: [
    'tasks:setup',
    'tasks:pre_test',
    'tasks:test',
    'tasks:post_test',
    'tasks:build'
  ] do
  end

  desc 'Run all tasks for the debug build.'
  task debug: [
    'tasks:setup',
    'tasks:test',
    'tasks:build'
  ] do
  end
end
