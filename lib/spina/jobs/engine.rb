module Spina
  module Jobs
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Jobs

      config.before_initialize do
        ::Spina::Plugin.register do |plugin|
          plugin.name = "jobs"
          plugin.namespace = 'jobs'
          plugin.settings = {
            confirmation_subject: {string: 'Thank you for your job application'},
            confirmation_message: {wysiwyg: "<div>Thank you for your job application %name%,</div><div></div><div>This email is a receipt to confirm we have received your job application and we'll be in touch shortly.</div><div></div><div>Thanks.</div>"},
            notification_subject: {string: 'New job application from your website'},
            notification_recipients: {string: (Spina::User.first.email rescue nil)}
          }
        end
      end

      initializer "spina-jobs.assets.precompile" do |app|
        app.config.assets.precompile += %w( spina/admin/jobs.css )
      end

      config.generators do |g|
        g.test_framework :rspec, fixture: false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.assets false
        g.helper false
      end

    end
  end
end
