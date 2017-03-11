require 'spec_helper'

RSpec.describe Tell::Interpreter::Lexer::Simple do


  context 'with a hello world program' do

    let(:program) do
      rel = '../../../../support/helloworld.tell'
      File.read(File.expand_path(rel, __FILE__))
    end
    let(:lexer) { build(:lexer, text: program) }

    it 'should find tokens' do
      # lexer wraps itself in enumerator
      tokens = lexer.tokens.entries
      expect(tokens).to match_array [
        :namespace,
        [:name, 'com.madsen'],
        :linebreak,
        :import,
        [:name, 'tell.io.Io'],
        :linebreak,
        :main_class,
        [:name, 'HelloWorld'],
        :linebreak,
        :pm,
        [:name, 'run'],
        :lpar,
        :asterix,
        :name,
        :rpar,
        :linebreak,
        [:name, 'io'],
        :equals,
        [:name, 'Io'],
        :dot,
        [:name, 'new'],
        :linebreak,
        [:name, 'io'],
        :dot,
        [:name, 'puts'],
        :lpar,
        :apo,
        [:name, 'Hello World'],
        :apo,
        :rpar,
        :comment,


      ]
    end
  end
end
