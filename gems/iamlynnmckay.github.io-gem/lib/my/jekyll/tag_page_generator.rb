# frozen_string_literal: true

require 'jekyll'

module My
  class TagPageGenerator < ::Jekyll::Generator
    safe true
    priority :high

    def generate(site)
      tags = site.posts.docs.flat_map { |post| post.data['tags'] }.uniq
      tags.each do |tag|
        site.pages << Page.new(site, tag)
      end
    end

    class Page < ::Jekyll::Page
      def initialize(site, tag)
        base = site.source
        dir = tag.to_s
        name = "#{tag}.html"
        super(site, site.source, '', name)
        process(name)
        read_yaml(File.join(base, '_layouts'), 'page.html')
        data['title'] = tag.to_s
        data['layout'] = 'page'
        data['permalink'] = "/#{tag}"
      end
    end
  end
end
