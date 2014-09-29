class CreateRiders < ActiveRecord::Migration
  def change
    create_table :riders do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.references :company, index: true

      t.timestamps
    end
  end
end
