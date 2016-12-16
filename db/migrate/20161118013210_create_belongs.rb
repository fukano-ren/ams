class CreateBelongs < ActiveRecord::Migration
  def change
    create_table :belongs do |t|
      t.string :code
      t.string :name
      t.string :model
      t.integer :department_id
      t.integer :user_id
      t.date :acquired_on
      t.date :disponed_on
      t.text :memo
      t.boolean :delete_flg
      t.datetime :updated_at
      t.datetime :created_at
      t.string :set
      t.timestamps null: false
    end
  end
end
