FactoryGirl.define do
  factory :lexer, class: Tell::Interpreter::Lexer::Simple do
    text 'yo'
    initialize_with { new(text) }
  end
end
