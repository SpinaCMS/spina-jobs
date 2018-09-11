require 'rails_helper'

module Spina
  RSpec.describe Jobs::JobRolesController, type: :controller do
    let!(:account) { ::Spina::Account.create(name: 'MySite', theme: 'default') }
    let(:job_roles) { create_list(:spina_jobs_job_role, 3, enabled: true, draft: false) }
    let(:job_role) { create(:spina_jobs_job_role, enabled: true, draft: false) }

    describe 'GET #index' do
      subject { get :index }
      before { job_roles }

      it { is_expected.to render_template :index }
      it { is_expected.to be_successful }

      it 'assigns job roles' do
        subject
        expect(assigns(:job_roles)).to match_array job_roles
      end
    end

    describe 'GET #show' do
      subject { get :show, params: { id: job_role.id } }
      it { is_expected.to render_template :show }
      it { is_expected.to be_successful }

      it 'assigns job role' do
        subject
        expect(assigns(:job_role)).to eq job_role
      end
    end
  end
end
