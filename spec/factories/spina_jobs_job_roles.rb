FactoryGirl.define do
  factory :spina_jobs_job_role, class: 'Spina::Jobs::JobRole' do
    sequence(:title) { |n| "Job Role #{n}"}
    introduction "MyText"
    description "MyText"
  end
end
