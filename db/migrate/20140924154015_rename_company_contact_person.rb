class RenameCompanyContactPerson < ActiveRecord::Migration
  def change
    rename_column :companies, :contact_oerson, :contact_person
  end
end
