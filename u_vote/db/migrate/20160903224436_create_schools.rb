class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.integer :unitid
      t.string :tinstnm
      t.string :stabbr
      t.string :fip
      t.integer :fips
      t.string :webaddr
      t.integer :countycd
      t.string :countynm
      t.integer :enrollment2015
      t.string :merge
      t.integer :participation
    end
  end
end
