require 'spec_helper'

RSpec.describe Tell::Interpreter::Lexer::Simple do
  context 'with single item input' do
    let(:lexer) { build(:lexer, text: snippet) }

    [
      ['class', 'class', :class],
      ['main class', 'main class', :main_class],
      ['dot', '.', :dot],
      ['namespace', 'namespace', :namespace],
      ['name', 'some_name', [:name, 'some_name']],
      ['line break', "\n", :linebreak],
    ].each do |(description, code, expected_token)|

      context "containing #{description} snippet" do
        let(:snippet) { code }
        it "finds #{expected_token.inspect} token only" do
          tokens = lexer.tokens
          expect(tokens.size).to eq 1
          expect(tokens.first).to eq expected_token
        end
      end
    end
  end

  context 'with multiple items in input' do
    let(:lexer) { build(:lexer, text: snippet) }
    [
      [
        'namespace declaration',
        "namespace com.madsen\n",
        [:namespace, [:name, 'com.madsen'], :linebreak],
      ],
      [
        'import statement followed by main class declaration',
        "import tell.io.Io\n\n\nmain class HelloWorld\n",
        [:import, [:name, 'tell.io.Io'],
         :linebreak, :linebreak, :linebreak,
         :main_class, [:name, 'HelloWorld'],
         :linebreak],
      ],
    ].each do |(description, code, expected_tokens)|

      context "containing #{description} snippet" do
        let(:snippet) { code }
        it 'finds expected tokens only' do
          tokens = lexer.tokens
          expect(tokens).to match_array expected_tokens
          expect(tokens).to eq expected_tokens
        end
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
      expect(tokens).to match_array hello_world_tokens
    end
  end

  def hello_world_tokens
    [:namespace, [:name, 'com.madsen'], :linebreak,
     :import, [:name, 'tell.io.Io'], :linebreak,
     :main_class, [:name, 'HelloWorld'], :linebreak,
     :pm, [:name, 'run'], :lpar, :asterix, [:name, 'args'], :rpar, :linebreak,
     [:name, 'io'], :equals, [:name, 'Io'], :dot, [:name, 'new'], :linebreak,
     [:name, 'io'], :dot, [:name, 'puts'], :lpar,
     :apo, [:name, 'Hello World'], :apo,
     :rpar, :comment]
  end
end
