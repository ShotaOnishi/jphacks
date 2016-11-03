class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.integer :group_id
      t.text :message

      t.timestamps
    end
  end
end
