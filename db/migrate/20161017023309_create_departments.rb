class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :code
      t.string :name
      t.datetime :updated_at
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
