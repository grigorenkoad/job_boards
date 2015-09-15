class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.string :description
      t.string :company
      t.string :category
      t.string :url
      t.string :req_num
      t.datetime :posted_at

      t.timestamps null: false
    end
  end
end
