class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :answer_type
      t.references :review, index: true

      t.timestamps
    end
  end
end
