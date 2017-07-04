require 'rails_helper'

module Spina::Admin
  RSpec.describe Jobs::JobApplicationsController, type: :controller do
    let(:job_application) { FactoryGirl.create :spina_jobs_job_application }
    let(:job_applications) { FactoryGirl.create_list :spina_jobs_job_application, 3 }

    context 'signed in as an admin' do
      before { sign_in }

      describe 'GET #index' do
        subject { get :index }
        it { is_expected.to render_template :index }
        it { is_expected.to have_http_status :success }

        it 'assigns job applications' do
          subject
          expect(assigns(:job_applications)).to match_array job_applications
        end

        context 'for a specific job role' do
          let(:job_role) { FactoryGirl.create :spina_jobs_job_role }
          let(:job_applications) { FactoryGirl.create_list :spina_jobs_job_application, 3, job_role: job_role }
          subject { get :index, params: { job_role_id: job_role.id } }

          it { is_expected.to render_template :index }
          it { is_expected.to have_http_status :success }

          it 'assigns job applications' do
            subject
            expect(assigns(:job_applications)).to match_array job_applications
          end
        end
      end

      describe 'GET #show' do
        subject { get :show, params: { id: job_application.id } }
        it { is_expected.to render_template :show }
        it { is_expected.to have_http_status :success }
      end

      describe 'DELETE #destroy' do
        subject { delete :destroy, params: { id: job_application.id } }
        before { job_application }
        it { expect{subject}.to change(Spina::Jobs::JobApplication, :count).by(-1) }
      end
    end

    context 'not signed in' do
      describe 'GET #index' do
        subject { get :index }
        it { is_expected.to_not have_http_status :success }
        it { is_expected.to_not render_template :index }
      end
    end
  end
end
