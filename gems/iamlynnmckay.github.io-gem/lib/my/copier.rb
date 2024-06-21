# frozen_string_literal: true

require 'fileutils'
require 'my/gitignore'

module My
  class Copier
    def initialize(source_dir, destination_dir)
      @source_dir = source_dir
      @destination_dir = destination_dir
      @gitignore = setup_gitignore
    end

    def copy
      copy_directory(@source_dir, @destination_dir)
    end

    private

    def setup_gitignore
      gitignore_file = File.join(@source_dir, '.gitignore')
      if File.exist?(gitignore_file)
        Gitignore.new(gitignore_file)
      else
        Gitignore.new([]) # No .gitignore file, so no patterns to ignore
      end
    end

    def copy_file(file, destination)
      FileUtils.mkdir_p(File.dirname(destination))
      FileUtils.cp(file, destination)
    end

    def copy_directory(src, dest)
      Dir.glob("#{src}/**/*", File::FNM_DOTMATCH).each do |file|
        # Skip the .gitignore file in the source directory
        next if File.basename(file) == '.gitignore'

        # Skip files and directories according to the .gitignore patterns
        next if @gitignore&.ignored?(file.sub("#{src}/", ''))

        dest_file = File.join(dest, file.sub("#{src}/", ''))
        if File.directory?(file)
          FileUtils.mkdir_p(dest_file)
        else
          copy_file(file, dest_file)
        end
      end
    end
  end
end
