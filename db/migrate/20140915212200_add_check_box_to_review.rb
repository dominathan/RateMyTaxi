class AddCheckBoxToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :use_this_review, :boolean
  end
end
