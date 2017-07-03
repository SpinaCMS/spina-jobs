module Spina::Jobs
  class JobRole < ApplicationRecord
    extend FriendlyId

    friendly_id :friendly_id_source, use: :slugged

    validates_presence_of   :title, :description
    validates_uniqueness_of :title

    validates_length_of :title, :employment_terms, :ref, :education, :experience,
      :skills, :languages, :salary, :hours, :employment_terms, :length, :contact,
      maximum: 255

      scope :available, -> { where('published_at <= ?', Time.zone.now) }
      scope :future, -> { where('published_at >= ?', Time.zone.now) }
      scope :draft, -> { where(draft: true) }
      scope :live, -> { where(draft: false) }

    before_save :set_published_at

    def disabled?
      !enabled?
    end

    def live?
      !draft?
    end

    private

    def set_published_at
      self.published_at = Time.zone.now if live? and published_at.blank?
    end

    # If title changes tell friendly_id to regenerate slug when saving record
    def should_generate_new_friendly_id?
      title_changed?
    end

    def friendly_id_source
      title
    end

  end
end
