# frozen_string_literal: true

require_relative 'type'
module My
  module Html
    module Resource
      class Css < My::Html::Resource::Type
        def self.as_html(from: String, **)
          "<link rel='stylesheet' href='#{from}'>"
        end

        def self.extnames
          ['.css']
        end
      end
    end
  end
end
