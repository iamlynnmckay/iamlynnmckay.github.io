# frozen_string_literal: true

require 'uri'

module My
  module Html
    module Resource
      class Type
        def self.as_html(**)
          raise NotImplementedError, "as_html method not implemented for #{self.class}"
        end

        def self.as_html?(from: String, **)
          (scheme?(from) && extname?(from) && format?(from))
        end

        def self.default?
          false
        end

        def self.extnames
          []
        end

        def self.extname?(from)
          extnames.include?(File.extname(from).downcase)
        end

        def self.schemes
          ['http', 'https', nil]
        end

        def self.scheme?(from)
          schemes.include?(URI.parse(from).scheme)
        end

        def self.formats
          %w[uri absolute_path relative_path]
        end

        def self.format?(from)
          format = if !URI(from).scheme.nil?
                     'uri'
                   elsif Pathname.new(from).absolute?
                     'absolute_path'
                   else
                     'relative_path'
                   end
          formats.include?(format)
        end
      end
    end
  end
end
