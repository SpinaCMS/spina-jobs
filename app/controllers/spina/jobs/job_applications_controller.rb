module Spina::Jobs
  class JobApplicationsController < ::Spina::ApplicationController
    before_action :find_job_role, except: :thanks
    before_action :set_page

    def new
      @job_application = @job_role.job_applications.new
      render layout: "#{current_theme.name.parameterize.underscore}/application"
    end

    def create
      @job_application = @job_role.job_applications.new job_application_params

      if @job_application.save
        begin
          JobApplicationMailer.notification(@job_application, request).deliver
        rescue
          logger.warn "There was an error delivering the job application notification:\n#{$!}\n"
        end

        begin
          JobApplicationMailer.confirmation(@job_application, request).deliver
        rescue
          logger.warn "There was an error delivering the job application confirmation:\n#{$!}\n"
        end

        redirect_to applications_thanks_jobs_job_roles_path
      else
        render :new, layout: "#{current_theme.name.parameterize.underscore}/application"
      end
    end

    def thanks
      render layout: "#{current_theme.name.parameterize.underscore}/application"
    end

    private

    def find_job_role
      @job_role = JobRole.friendly.find(params[:job_role_id])
    end

    def job_application_params
      params.require(:job_application).permit(:name, :phone, :email, :cover_letter, :file)
    end

    def set_page
      @page = Spina::Page.find_or_create_by name: 'jobs' do |page|
        page.link_url = '/jobs'
        page.title = 'Jobs'
        page.view_template = 'show'
        page.deletable = false
      end
    end
  end
end
