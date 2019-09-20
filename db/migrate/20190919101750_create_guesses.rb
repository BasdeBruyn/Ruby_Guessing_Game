class CreateGuesses < ActiveRecord::Migration[5.1]
  def change
    create_table :guesses do |t|
      t.string :name
      t.integer :previous_number
      t.integer :next_number
      t.string :guess

      t.timestamps
    end
  end
end
