class Guess < ApplicationRecord
  def self.create_guess(name:, previous_number: nil, next_number: nil, guess: nil, correct: nil)
    new_guess = Guess.new
    new_guess.name = name
    new_guess.previous_number = previous_number
    new_guess.next_number = next_number
    new_guess.guess = guess
    new_guess.correct = correct

    new_guess
  end

  def determine_winning_streak
    guesses = Guess.order(created_at: :desc).where(name: name)
    streak = 0

    guesses.each do |guess|
      return streak unless guess.correct

      streak += 1
    end
  end
end
