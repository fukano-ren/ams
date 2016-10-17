class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :code
      t.string :name
      t.string :password
      t.integer :department_id
      t.boolean :system
      t.boolean :admin
      t.datetime :updated_at
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
