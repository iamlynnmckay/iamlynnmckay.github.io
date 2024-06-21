# frozen_string_literal: true

require 'jekyll'

module My
  class TreePageBuilder
    def initialize(
      site:,
      page_permalink:, page_name: nil,
      page_title: nil,
      page_layout: nil,
      include_pages: false,
      include_posts: false,
      include_collections: false,
      include_static_files: false,
      prefix_filter: nil,
      suffix_filter: nil,
      collections_filter: nil
    )
      pages = build_pages(site, include_pages, prefix_filter, suffix_filter)
      posts = build_posts(site, include_posts, prefix_filter, suffix_filter)
      collections = build_collections(site, include_collections, collections_filter, prefix_filter, suffix_filter)
      static_files = build_static_files(site, include_static_files, prefix_filter, suffix_filter)
      paths = build_paths(pages, posts, collections, static_files)
      content = build_content(paths)
      page = build_page(site, page_name, page_title, page_layout, page_permalink, content)
      @page = page
    end

    def build
      @page
    end

    private

    def filter_paths(paths, prefix_filter, suffix_filter)
      paths = paths.filter { |path| path.start_with?(prefix_filter) } unless prefix_filter.nil?
      paths = paths.filter { |path| path.start_with?(suffix_filter) } unless suffix_filter.nil?
      paths
    end

    def build_pages(site, include_pages, prefix_filter, suffix_filter)
      return [] unless include_pages

      paths = site.pages.map(&:url)
      filter_paths(paths, prefix_filter, suffix_filter)
    end

    def build_posts(site, include_posts, prefix_filter, suffix_filter)
      return [] unless include_posts

      paths = site.posts.map(&:url)
      filter_paths(paths, prefix_filter, suffix_filter)
    end

    def build_collections(site, include_collections, collections_filter, prefix_filter, suffix_filter)
      return [] unless include_collections

      paths = site.collections
                  .filter { |name, _collection| collections_filter.nil? || collections_filter.include?(name) }
                  .map { |_name, collection| collection.docs.map(&:url) }.flatten
      filter_paths(paths, prefix_filter, suffix_filter)
    end

    def build_static_files(site, include_static_files, prefix_filter, suffix_filter)
      return [] unless include_static_files

      paths = site.static_files.map(&:relative_path)
                  .map { |path| path.sub(/^_/, '/') }
                  .filter { |path| !path.nil? }
      filter_paths(paths, prefix_filter, suffix_filter)
    end

    def build_paths(pages, posts, collections, static_files)
      (pages + posts + collections + static_files)
        .uniq
        .sort_by { |path| [path, path.include?('.') ? 0 : 1, -path.split('/').length] }
    end

    def build_content(paths)
      raw_tree = build_raw_tree(paths)
      html_tree = build_html_tree(raw_tree)
    end

    def build_raw_tree(paths)
      tree = {}

      paths.each do |path|
        parts = path.split('/')[1..] # Split path and remove the root element
        current_path = ''
        node = tree
        next if parts.nil? || parts.empty?

        parts.each_with_index do |part, index|
          current_path = File.join(current_path, part)
          if index == parts.length - 1
            node[current_path] = nil # File node
          else
            node[current_path] ||= {}  # Directory node
            node = node[current_path]
          end
        end
      end

      tree
    end

    def build_html_tree(tree, level = 0)
      html = '<ul>'
      tree.each do |path, children|
        basename = File.basename(path)
        html += '<li>'
        if children.nil?
          html += "<a href=\"#{path}\">#{basename}</a>"
        else
          html += "#{basename}/\n"
          html += "<ul>\n"
          html += build_html_tree(children, level + 1)
          html += "</ul>\n"
        end
        html += "</li>\n"
      end
      html += '</ul>'
      html
    end

    def build_page(site, page_name, page_title, page_layout, page_permalink, content)
      root = page_permalink.sub(%r{^/}, '')
      page_name ||= "#{root}.html"
      page_title ||= root
      page_layout ||= root
      page = Jekyll::Page.new(site, site.source, '', page_name)
      page.data['layout'] = page_layout
      page.data['title'] = page_title
      page.data['permalink'] = page_permalink
      page.content = content.to_s
      page
    end
  end
end
