# frozen_string_literal: true

require 'jekyll'
require 'logger'
require_relative '../helper'
require_relative '../html'
require_relative 'tag_arguments'

module My
  class EmbedTag < ::Liquid::Tag
    VERSION = '0.0.1'
    DEFAULT_ARGUMENTS = {}.freeze

    def initialize(tag_name, markup, tokens)
      super
      @markup = markup
      @logger = Logger.new($stdout)
    end

    def render(context)
      validate_version(context)
      arguments = parse_arguments(@markup, context)
      child_path = arguments[:from]
      unless My::Helper.is_uri(child_path) || My::Helper.is_absolute_path(child_path)
        parent_path = context.registers[:arguments][:from]
        child_path = Pathname.new(parent_path).dirname.join(child_path).cleanpath.to_s
      end
      arguments[:from] = child_path
      My::Html::Resources.as_html(context: context, **arguments)
    end

    def validate_version(context)
      version = context.registers[:site].config.dig('versions', 'plugins', 'asset_tag')
      return unless version != VERSION

      raise StandardError, "Plugin version mismatch: expected #{VERSION}, found #{version} in config.yml"
    end

    def parse_arguments(markup, context)
      My::TagArguments.new(context, markup, DEFAULT_ARGUMENTS.dup).to_hash
    end
  end
end
