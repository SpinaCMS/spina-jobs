module Spina::Jobs
  class JobApplicationMailer < ApplicationMailer

    def confirmation(job_application, request)
      @job_application, @request = job_application, request
      mail subject: Spina::Jobs::Setting.first.confirmation_subject,
        to: job_application.email,
        from: from_info,
        reply_to: Spina::Jobs::Setting.first.notification_recipients.split(',').first
    end

    def notification(job_application, request)
      @job_application, @request = job_application, request
      @host = [request.protocol, request.host_with_port].join

      mail subject: Spina::Jobs::Setting.first.notification_subject,
        to: Spina::Jobs::Setting.first.notification_recipients,
        from: from_info,
        reply_to: @job_application.email
    end

    private

    def from_info
      "\"#{from_name}\" <#{from_mail}>"
    end

    def from_name
      I18n.t 'spina.jobs.job_applications.from_name',
        site_name: Spina::Account.first.name,
        name: @job_application.name
    end

    def from_mail
      "#{Spina::Jobs.from_name}@#{@request.domain}"
    end
  end
end
