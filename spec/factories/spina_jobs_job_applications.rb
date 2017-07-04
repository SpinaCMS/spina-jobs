FactoryGirl.define do
  factory :spina_jobs_job_application, class: 'Spina::Jobs::JobApplication' do
    association :job_role, factory: :spina_jobs_job_role
    name "MyString"
    phone "MyString"
    sequence(:email) { |n| "applicant_#{n}@example.com" }
    cover_letter "MyText"
    file { fixture_file_upload('spec/factories/support/cv.odt') }
  end
end
