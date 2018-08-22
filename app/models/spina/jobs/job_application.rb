module Spina::Jobs
  class JobApplication < ApplicationRecord
    belongs_to :job_role

    has_one_attached :file

    belongs_to :job_role

    validates :name, :phone, :email, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
      length: { maximum: 255 }
    validates :cover_letter, presence: true, if: :cover_letter_required?
    validates :file, presence: true, if: :cv_required?
    # TODO: validate file size

    def cv_required?
      true
    end

    def cover_letter_required?
      true
    end
  end
end
