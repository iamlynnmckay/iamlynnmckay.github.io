# frozen_string_literal: true

require 'jekyll'
require 'my'

module Jekyll
  class AssetsPageGenerator < ::Jekyll::Generator
    safe true
    priority :lowest

    def generate(site)
      tree_page_builder = My::TreePageBuilder.new(
        site: site,
        prefix_filter: '/assets',
        page_permalink: '/assets',
        include_static_files: true
      )
      site.pages << tree_page_builder.build
    end
  end
end
