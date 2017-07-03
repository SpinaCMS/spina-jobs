class CreateSpinaJobsJobRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :spina_jobs_job_roles do |t|
      t.string :title
      t.text :introduction
      t.text :description
      t.string :employment_terms
      t.string :hours
      t.boolean :enabled
      t.string :slug
      t.boolean :draft
      t.datetime :published_at
      t.integer :fill
      t.string :ref
      t.date :employment_date
      t.string :education
      t.string :experience
      t.string :skills
      t.string :languages
      t.string :salary
      t.string :length
      t.string :contact

      t.timestamps
    end
  end
end
