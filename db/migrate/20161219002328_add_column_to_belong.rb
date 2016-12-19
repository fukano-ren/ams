class AddColumnToBelong < ActiveRecord::Migration
  def change
    add_column :belongs, :soft_destroyed_at, :datetime
    add_index :belongs, :soft_destroyed_at
  end
end
