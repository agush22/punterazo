class AddStatusToFields < ActiveRecord::Migration
  def change
    change_table :fields do |t|
      t.string :status
    end
  end
end
