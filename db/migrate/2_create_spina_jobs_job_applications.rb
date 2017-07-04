class CreateSpinaJobsJobApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_jobs_job_applications do |t|
      t.references :job_role, foreign_key: { to_table: :spina_jobs_job_roles }
      t.string :name
      t.string :phone
      t.string :email
      t.text :cover_letter
      t.string :file

      t.timestamps
    end
  end
end
