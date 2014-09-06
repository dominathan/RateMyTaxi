class AddTaxiReferencesToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :taxi, index: true
  end
end
