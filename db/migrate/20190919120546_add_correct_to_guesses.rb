class AddCorrectToGuesses < ActiveRecord::Migration[5.1]
  def change
    add_column :guesses, :correct, :boolean
  end
end
