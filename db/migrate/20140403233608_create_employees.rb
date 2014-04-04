class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :type
      t.references :position, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
