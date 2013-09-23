class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :content
      t.string :name
      t.text :description
	  t.belongs_to :attachable, :polymorphic => true

      t.timestamps
    end

	add_index :images, [:attachable_id, :attachable_type]
  end
end
