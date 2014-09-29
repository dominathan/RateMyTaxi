class AddNewFieldsToTaxi < ActiveRecord::Migration
  def change
    add_column :taxis, :company_vehicle_number, :string
    add_column :taxis, :license_plate, :string
  end
end
