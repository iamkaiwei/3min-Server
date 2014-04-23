class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :content
      t.integer :subject_id
      t.string :subject_type
      t.integer :user_id

      t.timestamps
    end
  end
end
