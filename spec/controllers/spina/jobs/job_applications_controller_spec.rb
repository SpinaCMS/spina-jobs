require 'rails_helper'

module Spina::Jobs
  RSpec.describe JobApplicationsController, type: :controller do
    let!(:account) { ::Spina::Account.create(name: 'MySite', theme: 'default') }
    let(:job_role) { create(:spina_jobs_job_role) }
    let(:attributes) { attributes_for(:spina_jobs_job_application) }

    describe 'GET #new' do
      subject { get :new, params: { job_role_id: job_role.id } }
      it { is_expected.to be_successful }
      it { is_expected.to render_template :new }
    end

    describe 'POST #create' do
      subject { post :create, params: { job_role_id: job_role.id, job_application: attributes } }
      it { expect{subject}.to change(Spina::Jobs::JobApplication, :count).by(1) }
      it { is_expected.to have_http_status :redirect }

      context 'with invalid parameters' do
        subject { post :create, params: { job_role_id: job_role.id, job_application: { name: 'foo' } } }
        it { expect{subject}.to_not change(Spina::Jobs::JobApplication, :count) }
        it { is_expected.to render_template :new }
        it { is_expected.to be_successful }
      end
    end
  end
end
