# frozen_string_literal: true

require_relative 'type'

module My
  module Html
    module Resource
      class Audio < My::Html::Resource::Type
        def self.as_html(from: String, **)
          "<audio src='#{from}' controls></audio>"
        end

        def self.extnames
          ['.mp3', '.ogg', '.wav']
        end
      end
    end
  end
end
