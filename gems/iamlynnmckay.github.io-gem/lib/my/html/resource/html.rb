# frozen_string_literal: true

require_relative 'type'
require_relative '../../helper'

module My
  module Html
    module Resource
      class Html < My::Html::Resource::Type
        def self.as_html(from: String, content: nil, **)
          content = from if content.nil?
          "<a href=\"#{from}\">#{content}</a>"
        end

        def self.extnames
          ['.html', '.htm']
        end
      end
    end
  end
end
