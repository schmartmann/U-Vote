class AddZipColumnToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :zip, :integer
  end
end
