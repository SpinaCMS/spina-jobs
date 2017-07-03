module Spina
  module Admin
    module Jobs
      class JobRolesController < AdminController
        before_action :set_breadcrumb
        before_action :set_tabs, only: [:new, :create, :edit, :update]
        before_action :set_locale

        decorates_assigned :job

        layout 'spina/admin/jobs'

        def index
          @job_roles = Spina::Jobs::JobRole.order(created_at: :desc).decorate
        end

        def show
          @job_role = Spina::Jobs::JobRole.find params[:id]
        end

        def new
          @job_role = Spina::Jobs::JobRole.new(enabled: true)
          add_breadcrumb I18n.t('spina.jobs.job_roles.new')
          render layout: 'spina/admin/admin'
        end

        def create
          @job_role = Spina::Jobs::JobRole.new job_params
          if @job_role.save
            redirect_to spina.edit_admin_jobs_job_role_url(@job_role.id), notice: t('spina.jobs.job_roles.saved')
          else
            add_breadcrumb I18n.t('spina.jobs.job_roles.new')
            render :new, layout: 'spina/admin/admin'
          end
        end

        def edit
          @job_role = Spina::Jobs::JobRole.find params[:id]
          add_breadcrumb @job_role.title
          render layout: 'spina/admin/admin'
        end

        def update
          I18n.locale = params[:locale] || I18n.default_locale
          @job_role = Spina::Jobs::JobRole.find(params[:id])
          respond_to do |format|
            if @job_role.update_attributes(job_params)
              add_breadcrumb @job_role.title
              @job_role.touch
              I18n.locale = I18n.default_locale
              format.html { redirect_to spina.edit_admin_jobs_job_role_url(@job_role.id, params: {locale: @locale}), notice: t('spina.jobs.job_roles.saved') }
              format.js
            else
              format.html do
                render :edit, layout: 'spina/admin/admin'
              end
            end
          end
        end

        def destroy
          @job_role = Spina::Jobs::JobRole.find(params[:id])
          @job_role.destroy
          redirect_to spina.admin_jobs_job_roles_path
        end

        private

        def set_breadcrumb
          add_breadcrumb I18n.t('spina.jobs.job_roles.title'), spina.admin_jobs_job_roles_path
        end

        def set_tabs
          @tabs = %w{job_content job_configuration}
        end

        def set_locale
          @locale = params[:locale] || I18n.default_locale
        end

        def job_params
          params.require(:job_role).permit(:title, :introduction, :description, :education,
            :experience, :skills, :languages, :salary, :employment_terms, :length_of_employment,
            :hours, :fill, :employment_date, :ref, :enabled, :draft, :published_at, :contact
          )
        end

      end
    end
  end
end
