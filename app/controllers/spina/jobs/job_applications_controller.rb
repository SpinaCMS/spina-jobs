module Spina::Jobs
  class JobApplicationsController < ::Spina::ApplicationController
    before_action :find_job_role, except: :thanks

    def new
      @job_application = @job_role.job_applications.new
    end

    def create
      @job_application = @job_role.job_applications.new job_application_params

      if @job_application.save
        redirect_to applications_thanks_jobs_job_roles_path
      else
        render :new
      end
    end

    def thanks
    end

    private

    def find_job_role
      @job_role = JobRole.friendly.find(params[:job_role_id])
    end

    def job_application_params
      params.require(:job_application).permit(:name, :phone, :email, :cover_letter, :file)
    end
  end
end
