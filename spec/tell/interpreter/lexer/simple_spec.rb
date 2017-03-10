require 'spec_helper'

RSpec.describe Tell::Interpreter::Lexer::Simple do
  let(:lexer) { build(:lexer) }

  it 'can be created' do
    expect(lexer).not_to be nil
  end
end
