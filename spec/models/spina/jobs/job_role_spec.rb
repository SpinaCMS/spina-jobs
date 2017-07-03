require 'rails_helper'

module Spina::Jobs
  RSpec.describe JobRole, type: :model do
    subject { FactoryGirl.build :spina_jobs_job_role, title: 'My Title' }

    it { is_expected.to be_valid }

    it 'returns a slug' do
      subject.save
      expect(subject.reload.slug).to eq 'my-title'
    end
  end
end
