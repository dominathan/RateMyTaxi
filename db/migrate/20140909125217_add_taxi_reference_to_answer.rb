class AddTaxiReferenceToAnswer < ActiveRecord::Migration
  def change
    add_reference :answers, :taxi, index: true
  end
end
