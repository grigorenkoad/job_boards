class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :location
      t.string :company
      t.string :category

      t.timestamps null: false
    end
  end
end
