# frozen_string_literal: true

module My
  class Gitignore
    def initialize(gitignore_file = '.gitignore')
      @patterns = []
      @compiled_patterns = compile_patterns
      @gitignore_file = File.expand_path(gitignore_file)
      set_patterns_from_file
    end

    # Set or update the .gitignore patterns from an array of patterns
    def set_patterns(patterns)
      @patterns = patterns
      @compiled_patterns = compile_patterns
    end

    # Set or update the .gitignore patterns from a file
    def set_patterns_from_file
      if File.exist?(@gitignore_file)
        @patterns = File.readlines(@gitignore_file).map(&:strip).reject(&:empty?)
        @compiled_patterns = compile_patterns
      else
        raise ArgumentError, "File not found: #{file_path}"
      end
    end

    # Check if a path is ignored
    def ignored?(path)
      @compiled_patterns.any? { |pattern| pattern.match?(path) }
    end

    private

    # Compile patterns into regular expressions
    def compile_patterns
      @patterns.map do |pattern|
        # Handle negation (e.g., !pattern)
        # next if pattern.start_with?('#')
        if pattern.start_with?('!')
          negative_pattern = pattern[1..]
          Regexp.new(negative_pattern, Regexp::IGNORECASE)
        else
          # Handle normal patterns
          adjusted_pattern = pattern
          adjusted_pattern = "**/#{adjusted_pattern}" unless adjusted_pattern.start_with?('*')
          adjusted_pattern = "#{adjusted_pattern}/*" if adjusted_pattern.end_with?('/')
          Regexp.new(adjusted_pattern.gsub('*', '.*').tr('?', '.'), Regexp::IGNORECASE)
        end
      end
    end
  end
end
