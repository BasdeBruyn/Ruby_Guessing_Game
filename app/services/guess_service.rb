class GuessService
  HIGHER = 'higher'
  LOWER = 'lower'

  def self.retrieve_guesses
    Guess.order(created_at: :desc)
  end

  def self.create_guess_page(guess, name)
    current_guess = Guess.create_guess(name: name, guess: guess)

    winning_streak = 0

    initial = initial_game? guess

    if initial
      initialize_guessing_game(current_guess)
    else
      handle_guess(current_guess)

      winning_streak = current_guess.determine_winning_streak
    end

    create_and_save_new_guess(current_guess)

    @guess_page = GuessPage.new(current_guess, initial, winning_streak)
  end

  GuessPage = Struct.new(:current_guess, :initial, :winning_streak)

  private

  def self.handle_guess(current_guess)
    previous_guess = Guess.order(created_at: :desc).where(name: current_guess.name).first

    current_guess.previous_number = previous_guess.previous_number
    current_guess.next_number = create_random_number(current_guess.previous_number)

    current_guess.correct = guess_correct? current_guess

    update_previous_guess(previous_guess, current_guess)
  end

  def self.initial_game?(guess)
    guess != HIGHER && guess != LOWER
  end

  def self.initialize_guessing_game(current_guess)
    number = create_random_number(current_guess.previous_number)
    current_guess.previous_number = number
    current_guess.next_number = number
  end

  def self.create_random_number(excluded_number)
    available_numbers = (0..100).to_a - [excluded_number]
    number = rand(0..99)
    available_numbers[number]
  end

  def self.guess_correct?(guess)
    if guess.guess == HIGHER
      guess.next_number > guess.previous_number
    else
      guess.next_number < guess.previous_number
    end
  end

  def self.update_previous_guess(previous_guess, current_guess)
    previous_guess.next_number = current_guess.next_number
    previous_guess.guess = current_guess.guess
    previous_guess.correct = current_guess.correct

    previous_guess.save
  end

  def self.create_and_save_new_guess(current_guess)
    new_guess = Guess.create_guess(name: current_guess.name, previous_number: current_guess.next_number)

    new_guess.save
  end
end