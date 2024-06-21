# frozen_string_literal: true

namespace :cleaning do
  desc 'Clean up files ignored by .gitignore. This command removes all files that are listed in .gitignore but not tracked by Git.'
  task :clean do
    sh 'git ls-files --ignored --exclude-standard --others -o -i | xargs rm -f'
  end
  desc 'Run all cleaning tasks. This runs all cleaning tasks in sequence.'
  task all: [:clean] do
  end
end
