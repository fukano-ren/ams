class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :code
      t.string :name
      t.string :model
      t.integer :department_id
      t.integer :user_id
      t.date :acquired_on
      t.date :disposed_on
      t.text :memo
      t.boolean :delete_flg
      t.datetime :updated_at
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
