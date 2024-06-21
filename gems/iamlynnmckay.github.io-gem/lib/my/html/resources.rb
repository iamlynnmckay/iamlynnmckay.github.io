# frozen_string_literal: true

require_relative 'resource/type'
require_relative 'resource/css'
require_relative 'resource/image'
require_relative 'resource/js'
require_relative 'resource/pdf'
require_relative 'resource/pre'
require_relative 'resource/video'
require_relative 'resource/audio'
require_relative 'resource/html'
require_relative 'resource/markdown'
require_relative 'resource/iframe'

require 'logger'

module My
  module Html
    class Resources
      def self.klass
        My::Html::Resource::Type
      end

      def self.as_html(type: String, **arguments)
        content = ObjectSpace.each_object(Class).select { |k| k < klass }.find do |k|
          k if k.name.sub(/^.*::/, '').downcase == type
        end
        return content.as_html(**arguments) if content

        default = ObjectSpace.each_object(Class).select { |k| k < klass }.find do |k|
          k if k.default?
        end
        content = ObjectSpace.each_object(Class).select { |k| k < klass }.find do |k|
          k unless !k.as_html?(**arguments) || k.default?
        end
        return content.as_html(**arguments) if content
        return default.as_html(**arguments) if default.as_html?(**arguments)

        begin
          return super.as_html(**arguments) if super.as_html?(**arguments)
        rescue NoMethodError, NotImplementedError
        end
        raise ArgumentError, "No resource type found for #{arguments}"
      end
    end
  end
end
