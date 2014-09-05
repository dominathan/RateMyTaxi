class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.references :user_id, index: true
      t.string :driver_first_name
      t.string :driver_last_name
      t.string :driver_id

      t.timestamps
    end
  end
end
