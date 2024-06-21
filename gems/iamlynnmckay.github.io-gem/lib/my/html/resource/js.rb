# frozen_string_literal: true

require_relative 'type'
module My
  module Html
    module Resource
      class Js < My::Html::Resource::Type
        def self.as_html(from: String, **)
          "<script src='#{from}'></script>"
        end

        def self.extnames
          ['.js']
        end
      end
    end
  end
end
