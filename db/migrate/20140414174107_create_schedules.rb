class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :week_of, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
