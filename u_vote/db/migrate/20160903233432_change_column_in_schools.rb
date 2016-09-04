class ChangeColumnInSchools < ActiveRecord::Migration
  def change
    rename_column :schools, :tinstnm, :instnm
  end
end
