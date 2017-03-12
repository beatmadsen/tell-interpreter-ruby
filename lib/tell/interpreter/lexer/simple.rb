module Tell
  module Interpreter
    module Lexer
      # Simple implementation of a lexer
      class Simple
        def initialize(text)
          @text = text
        end

        def tokens
          case @text
          when 'class'
            [:class]
          when 'main class'
            [:main_class]
          when '.'
            [:dot]
          when 'namespace'
            [:namespace]
          when "\n"
            [:linebreak]
          else
            [[:name, @text]]
          end
        end
      end
    end
  end
end
