# frozen_string_literal: true

require 'uri'

module My
  class Helper
    # TODO: this method is used by resource classes,
    # but this should eventually be split into classes
    # for each resource type to actually download files
    # and convert files 'from' and 'to'

    def self.is_uri(maybe_uri)
      !URI(maybe_uri).scheme.nil?
    end

    def self.is_path(maybe_path)
      !is_uri(maybe_path)
    end

    def self.is_absolute_path(maybe_path)
      is_path(maybe_path) && Pathname.new(maybe_path).absolute?
    end

    def self.is_relative_path(maybe_path)
      is_path(maybe_path) && !is_absolute(maybe_path)
    end

    def self.is_descendant?(parent_path, child_path)
      parent_path = Pathname.new(parent_path)
      child_path = Pathname.new(child_path)
      parent_root = parent_path.each_filename.first
      child_root = child_path.each_filename.first
      parent_root == child_root
    end

    def self.resolve_parent_and_child_path(parent_path, child_path)
      unless is_descendant?(
        parent_path, child_path
      )
        raise ArgumentError,
              "child path is not a descendant of parent path (#{parent_path}, #{child_path})"
      end
    end

    def self.read_file_or_get_uri(file_path_or_uri)
      return Net::HTTP.get(URI(file_path_or_uri)) if is_uri(file_path_or_uri)

      File.read(file_path_or_uri)
    end
  end
end
