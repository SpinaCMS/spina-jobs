module Spina::Admin
  class Jobs::JobApplicationsController < AdminController
    before_action :find_collection, only: :index
    before_action :find_resource, only: [:show, :destroy]
    before_action :set_breadcrumb
    before_action :set_locale

    layout 'spina/admin/job_applications'

    def index
    end

    def show
      add_breadcrumb @job_application.name
      render layout: 'spina/admin/job_application'
    end

    def destroy
      @job_application.destroy
      redirect_to admin_jobs_job_applications_path, notice: 'Successfully deleted job application'
    end

    private

    def set_breadcrumb
      if @job_role
        add_breadcrumb @job_role.title, admin_jobs_job_roles_path
        add_breadcrumb I18n.t('spina.jobs.job_applications.title'), spina.admin_jobs_job_role_job_applications_path(@job_role.id)
      else
        add_breadcrumb I18n.t('spina.jobs.job_applications.title'), spina.admin_jobs_job_applications_path
      end
    end

    def set_locale
      @locale = params[:locale] || I18n.default_locale
    end

    def find_resource
      @job_application = Spina::Jobs::JobApplication.find params[:id]
      @job_role = @job_application.job_role
    end

    def find_collection
      if params[:job_role_id]
        @job_role = Spina::Jobs::JobRole.find(params[:job_role_id])
      end
      @job_applications = if @job_role
        @job_role.job_applications
      else
        Spina::Jobs::JobApplication.unscoped
      end
    end
  end
end
