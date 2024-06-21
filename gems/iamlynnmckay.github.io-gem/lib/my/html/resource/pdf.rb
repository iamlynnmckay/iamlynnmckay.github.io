# frozen_string_literal: true

require_relative 'type'
module My
  module Html
    module Resource
      class Pdf < My::Html::Resource::Type
        def self.as_html(from: String, width: '100%', height: '100%', **)
          "<embed src='#{from}' type='application/pdf' width='#{width}' height='#{height}'>"
        end

        def self.extnames
          ['.pdf']
        end
      end
    end
  end
end
