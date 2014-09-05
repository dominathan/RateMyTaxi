class RenameuserIdIdTouserId < ActiveRecord::Migration
  def change
    rename_column :taxis, :user_id_id, :user_id
  end
end
