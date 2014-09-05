class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :company_name
      t.integer :taxi_count

      t.timestamps
    end
  end
end
