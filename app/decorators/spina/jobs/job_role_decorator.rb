module Spina
  class Jobs::JobRoleDecorator < Draper::Decorator
    delegate_all

    def published_date
      l model.published_at, format: :long
    end

    def yet_to_be_published?
      model.live? and model.enabled? and model.published_at and model.published_at > Time.now
    end
  end
end
