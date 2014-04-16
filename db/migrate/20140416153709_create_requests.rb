class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      t.references :employee
      t.datetime :request_date
      t.string :request_type

      t.timestamps
    end
  end
end
