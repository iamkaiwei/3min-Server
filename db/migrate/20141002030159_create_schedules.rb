class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :operation_id

      t.timestamps
    end
  end
end
