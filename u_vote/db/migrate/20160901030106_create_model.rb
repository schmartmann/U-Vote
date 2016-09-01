class CreateModel < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :domain
      t.string :status
  end
end
