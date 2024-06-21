# frozen_string_literal: true

require 'my'
require 'jekyll'

module Jekyll
  class EmbedTag < ::My::EmbedTag
  end

  class TagPageGenerator < ::My::TagPageGenerator
  end
end

Liquid::Template.register_tag('embed', Jekyll::EmbedTag)
