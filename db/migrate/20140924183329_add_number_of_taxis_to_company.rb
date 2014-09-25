class AddNumberOfTaxisToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :taxi_count, :integer
  end
end
