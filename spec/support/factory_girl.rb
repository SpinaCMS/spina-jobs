RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl::SyntaxRunner.send(:include, ActionDispatch::TestProcess)
