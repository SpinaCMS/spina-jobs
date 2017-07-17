module Spina
  module Jobs
    class JobRolesController < ::Spina::ApplicationController
      before_action :set_page

      def index
        @job_roles = Spina::Jobs::JobRole.available.live.order(published_at: :desc).page(params[:page])

        respond_to do |format|
          format.atom
          format.html { render layout: "#{current_theme.name.parameterize.underscore}/application" }
        end
      end

      def show
        @job_role = Spina::Jobs::JobRole.friendly.find params[:id]

        render layout: "#{current_theme.name.parameterize.underscore}/application"
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
end
