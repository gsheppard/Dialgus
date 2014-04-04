class ChangeTypeToWorkType < ActiveRecord::Migration
  def up
    rename_column :employees, :type, :work_type
  end

  def down
    rename_column :employees, :work_type, :type
  end
end
