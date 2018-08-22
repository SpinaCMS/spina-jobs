require 'rails_helper'

module Spina::Jobs
  RSpec.describe JobApplication, type: :model do
    subject { FactoryBot.build :spina_jobs_job_application }

    it { is_expected.to be_valid }
  end
end
