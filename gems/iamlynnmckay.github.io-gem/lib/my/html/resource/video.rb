# frozen_string_literal: true

require_relative 'type'
module My
  module Html
    module Resource
      class Video < My::Html::Resource::Type
        def self.as_html(from: String, **)
          "<video src='#{from}' controls></video>"
        end

        def self.extnames
          ['.mp4', '.webm', '.ogv']
        end
      end
    end
  end
end
