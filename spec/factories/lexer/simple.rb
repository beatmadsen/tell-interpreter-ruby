FactoryGirl.define do
  factory :lexer, class: Tell::Interpreter::Lexer::Simple do
    text ''
    initalize_with { new(text) }
  end

end
