require 'rails_helper'

RSpec.feature "Job Roles", type: :feature do

  describe 'listing job roles' do
    let!(:posts) { FactoryBot.create_list :spina_jobs_job_role, 3 }
    let!(:future_post) { FactoryBot.create :spina_jobs_job_role, enabled: true, draft: false, published_at: Date.today + 1}
    before { sign_in }

    it 'shows all the job roles' do
      visit '/admin/jobs/roles'
      expect(page).to have_css 'tbody tr', count: 4

      within 'tbody tr', text: 'Will be published on' do
        expect(page).to have_content future_post.published_at.strftime('%B %d, %Y %H:%M')
      end
    end
  end
end
