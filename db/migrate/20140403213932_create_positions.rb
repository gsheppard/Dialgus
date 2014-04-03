class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_index :positions, :user_id
  end
end
