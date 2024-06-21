# frozen_string_literal: true

require 'jekyll'
require 'liquid'

require_relative 'type'
require_relative '../../helper'

module My
  module Html
    module Resource
      class Markdown < My::Html::Resource::Type
        def self.as_html(context:, **child_arguments)
          # TODO: fix this when you can to move from and level into named function args
          from = child_arguments[:from]
          level = child_arguments[:level] || 2
          content = My::Helper.read_file_or_get_uri(from.sub(%r{^/}, '_'))
          parent_arguments = context.registers[:arguments]
          # new_context = Liquid::Context.new(
          #  context.scopes, # The scopes (variables) from the parent document
          #  context.environments,
          #  context.registers
          # )
          context.registers[:arguments] = child_arguments
          # render liquid codee but do not convert markdown
          template = Liquid::Template.parse(content)
          content = template.render(context)
          # adjust the headings in the markdown document
          content = content.gsub(/^(#+)/) { |h| '#' * (level + h.length - 1) }
          # convert markdown
          converter = context.registers[:site].find_converter_instance(::Jekyll::Converters::Markdown)
          content = converter.convert(content)
          # restore parent properties
          context.registers[:arguments] = parent_arguments
          content
        end

        def self.extnames
          ['.markdown', '.md']
        end
      end
    end
  end
end
