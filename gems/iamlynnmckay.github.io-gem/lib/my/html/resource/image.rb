# frozen_string_literal: true

require_relative 'type'

module My
  module Html
    module Resource
      class Image < My::Html::Resource::Type
        def self.as_html(from: String, alt: '', **)
          "<img src='#{from}' alt='#{alt}'>"
        end

        def self.extnames
          ['.jpg', '.jpeg', '.png', '.gif', '.svg']
        end
      end
    end
  end
end
