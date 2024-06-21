# frozen_string_literal: true

require_relative 'type'
require_relative '../../helper'
require_relative 'html'

module My
  module Html
    module Resource
      class Raw < My::Html::Resource::Type
        def self.as_html(from: String, **)
          # TODO: duplicate code in markdown.rb for now
          My::Helper.read_file_or_get_uri(from.sub(%r{^/}, '_'))
        end

        def self.extname?(_uri)
          true
        end

        def self.schemes
          [nil]
        end
      end
    end
  end
end
