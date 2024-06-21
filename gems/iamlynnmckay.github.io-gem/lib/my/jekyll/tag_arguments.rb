# frozen_string_literal: true

module My
  class TagArguments
    STRING_SYNTAX = /(\w+)\s*=\s*["']([^"']+)["']/
    INTEGER_SYNTAX = /(\w+)\s*=\s*(\d+)/
    BOOLEAN_SYNTAX = /(\w+)\s*=\s*(true|false)/
    VARIABLE_SYNTAX = /(\w+)\s*=\s*([^"'\s]+)/

    def initialize(context, markup, default_arguments = {})
      @arguments = parse_tag_arguments(context, markup.strip, default_arguments)
    end

    def to_hash
      @arguments
    end

    private

    def parse_tag_arguments(context, markup, arguments = {})
      parse_string_arguments(markup, arguments)
      parse_integer_arguments(markup, arguments)
      parse_variable_arguments(context, markup, arguments)
      parse_boolean_arguments(markup, arguments)
      arguments
    end

    def parse_string_arguments(markup, arguments)
      markup.scan(STRING_SYNTAX) do |key, value|
        arguments[key.to_sym] = value
      end
    end

    def parse_integer_arguments(markup, arguments)
      markup.scan(INTEGER_SYNTAX) do |key, value|
        arguments[key.to_sym] = value.to_i
      end
    end

    def parse_boolean_arguments(markup, arguments)
      markup.scan(BOOLEAN_SYNTAX) do |key, value|
        arguments[key.to_sym] = value == 'true'
      end
    end

    def parse_variable_arguments(context, markup, arguments)
      markup.scan(VARIABLE_SYNTAX) do |key, value|
        resolved_value = lookup_variable(context, value)
        arguments[key.to_sym] = resolved_value
      end
    end

    def lookup_variable(context, variable)
      context[variable]
    end
  end
end
