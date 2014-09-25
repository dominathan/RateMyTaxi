class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :contact_oerson
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
