module Spina::Jobs
  # Preview all emails at http://localhost:3000/rails/mailers/job_application
  class JobApplicationPreview < ActionMailer::Preview
    def confirmation
      JobApplicationMailer.confirmation(JobApplication.first)
    end
  end
end
