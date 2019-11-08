class GuessPage

  attr_accessor :current_guess, :initial, :winning_streak

  def initialize (current_guess, initial, winning_streak)
    @current_guess = current_guess
    @initial = initial
    @winning_streak = winning_streak
  end
end