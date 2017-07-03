require 'rails_helper'

module Spina::Admin
  RSpec.describe Jobs::JobRolesController, type: :controller do
    let(:job_roles) { FactoryGirl.create_list :spina_jobs_job_role, 3 }
    let(:job_role) { FactoryGirl.create :spina_jobs_job_role }
    let(:attributes) { FactoryGirl.attributes_for :spina_jobs_job_role }

    context 'signed in as an admin' do
      before { sign_in }

      describe 'GET #index' do
        subject { get :index }
        it { is_expected.to render_template :index }
        it { is_expected.to have_http_status :success }

        it 'assigns job roles' do
          subject
          expect(assigns(:job_roles)).to match_array Spina::Jobs::JobRoleDecorator.new(job_roles)
        end
      end

      describe 'GET #new' do
        subject { get :new }
        it { is_expected.to render_template :new }
        it { is_expected.to have_http_status :success }

        it 'assigns job role' do
          subject
          expect(assigns(:job_role)).to be_an_instance_of Spina::Jobs::JobRole
        end
      end

      describe 'POST #create' do
        subject { post :create, params: { job_role: attributes } }
        it { is_expected.to have_http_status :redirect }
        it { expect{subject}.to change(Spina::Jobs::JobRole, :count).by(1) }

        context 'with invalid attributes' do
          subject { post :create, params: { job_role: { introduction: 'foo' } } }
          it { is_expected.to have_http_status :success }
          it { is_expected.to render_template :new }
          it { expect{subject}.to_not change(Spina::Jobs::JobRole, :count) }
        end
      end

      describe 'GET #edit' do
        subject { get :edit, params: { id: job_role.id } }
        it { is_expected.to have_http_status :success }
        it { is_expected.to render_template :edit }
        it 'assigns job role' do
          subject
          expect(assigns(:job_role)).to eq Spina::Jobs::JobRoleDecorator.new(job_role)
        end
      end

      describe 'PATCH #update' do
        subject { patch :update, params: { id: job_role.id, job_role: attributes } }
        it { is_expected.to redirect_to edit_admin_jobs_job_role_path(job_role.id, locale: I18n.default_locale) }
        it { expect{subject}.to change{job_role.reload.title} }
        it { expect{subject}.to change{job_role.reload.slug} }

        context 'with invalid attributes' do
          subject { post :update, params: { id: job_role.id, job_role: { title: '' } } }
          it { is_expected.to have_http_status :success }
          it { is_expected.to render_template :edit }
          it { expect{subject}.to_not change{job_role.reload.title} }
        end
      end

      describe 'DELETE #destroy' do
        subject { delete :destroy, params: { id: job_role.id } }
        before { job_role }
        it { expect{subject}.to change(Spina::Jobs::JobRole, :count).by(-1) }
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
