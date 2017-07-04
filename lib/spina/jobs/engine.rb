module Spina
  module Jobs
    class Engine < ::Rails::Engine
      isolate_namespace Spina::Jobs

      initializer "register plugin" do
        ::Spina::Plugin.register do |plugin|
          plugin.name = "jobs"
          plugin.namespace = 'jobs'
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
