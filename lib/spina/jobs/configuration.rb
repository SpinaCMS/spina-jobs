module Spina
  module Jobs
    include ActiveSupport::Configurable

    config_accessor :from_name

    self.from_name = 'no-reply'
  end
end
