# frozen_string_literal: true

namespace :backup do
  desc 'Add all changes to Git. This command adds all changes to the Git index.'
  task :add_all do
    sh 'git add --all'
  end

  desc 'Commit changes to Git. This commend creates a commit with the current date as the commit message, or does nothing if there is nothing to commit.'
  task :commit do
    sh 'git commit -m "$(date)" || echo'
  end

  desc 'Run all snpashot tasks. This runs all backup tasks in sequence.'
  task all: %i[add_all commit] do
  end
end
