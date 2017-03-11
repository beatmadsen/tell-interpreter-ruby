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
          when '.'
            [:dot]
          else
            []
          end
        end
      end
    end
  end
end
