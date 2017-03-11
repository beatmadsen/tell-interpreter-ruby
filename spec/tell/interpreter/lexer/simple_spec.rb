require 'spec_helper'

RSpec.describe Tell::Interpreter::Lexer::Simple do
  context 'with single item input' do
    let(:lexer) { build(:lexer, text: snippet) }

    context 'containing class snippet' do
      let(:snippet) { 'class' }
      it 'finds :class token only' do
        tokens = lexer.tokens
        expect(tokens.size).to eq 1
        expect(tokens.first).to eq :class
      end
    end

    context 'containing dot snippet' do
      let(:snippet) { '.' }
      it 'finds :class token only' do
        tokens = lexer.tokens
        expect(tokens.size).to eq 1
        expect(tokens.first).to eq :dot
      end
    end
  end

  context 'with a hello world program' do
    let(:program) do
      rel = '../../../../support/helloworld.tell'
      File.read(File.expand_path(rel, __FILE__))
    end
    let(:lexer) { build(:lexer, text: program) }

    xit 'should find tokens' do
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
        :comment

      ]
    end
  end
end
