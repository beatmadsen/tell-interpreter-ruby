require 'trie'

module Tell
  module Interpreter
    module Lexer
      # Simple implementation of a lexer
      class Simple
        class << self
          def populated_trie
            trie = Trie.new
            tokens_by_pattern.keys.each { |pattern| trie.add(pattern) }
            trie
          end

          def tokens_by_pattern
            @tokens_by_pattern ||= {
              'class' => :class,
              'main class' => :main_class,
              '.' => :dot,
              'namespace' => :namespace,
              "\n" => :linebreak,
            }
          end

          def trie
            @trie ||= populated_trie
          end
        end

        def initialize(text)
          @text = text
        end

        def tokens
          # TODO: make this lazier via enumerator
          result = []
          until @text.empty?
            count, token = consume_whitespace(@text)
            puts "P1. Count is #{count}"
            count, token = consume_token(@text) if count == 0
            puts "P2. Count is #{count}"
            count, token = consume_name(@text) if count == 0
            puts "P3. Count is #{count}"
            result << token if token
            @text.slice!(0..count-1)
            puts ({count: count, token: token, text: @text })
          end
          result
        end

        private

        def lookup_token_sym(text)
          self.class.tokens_by_pattern[text] ||
            raise("unexpected token text: #{text}")
        end

        def consume_token(text)
          prefix = ''
          text.each_char do |c|
            prefix << c
            children = self.class.trie.children(prefix)
            return [0, nil] if children.empty?
            next unless children.size == 1
            child = children.first
            return [0, nil] unless text.start_with?(child)
            token = lookup_token_sym(child)
            return [token.size, token]
          end
          raise 'failed while consuming token'
        end

        def consume_name(text)
          name = ''
          text.each_char do |c|
            case c
            when ' ', "\t", "\r", "\n"
              return [name.size, [:name, name]]
            else
              name << c
            end
          end
          [name.size, [:name, name]]
        end

        def consume_whitespace(text)
          count = 0
          token = nil
          text.each_char do |c|
            case c
            when ' ', "\t", "\r"
              count += 1
            when "\n"
              # don't match newline if it's the first encountered char
              return [count, token] unless count >= 1
              count += 1
            else
              return [count, token]
            end
          end
          [count, token]
        end
      end
    end
  end
end
