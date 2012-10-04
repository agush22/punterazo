class AddUserToFields < ActiveRecord::Migration
  def change
    change_table :fields do |t|
      t.references :user
    end
  add_index :fields, :user_id
  end
end
