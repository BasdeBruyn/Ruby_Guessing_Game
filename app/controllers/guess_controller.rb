class GuessController < ApplicationController

  def index

  end

  def guess_game
    @guess = params[:guess]
    @name = params[:name]
    @correct = false

    puts(@guess.to_s)

    case @guess
    when "lower"
      @higher = false
    when "higher"
      @higher = true
    else
      @initial = true
    end

    if @initial
      @previous_number = rand(101)
      @next_number = @previous_number
      @name = @guess[:name]
      puts(@name)
    else
      previous_guess = Guess.order(created_at: :desc).where(name: @name).first

      puts(previous_guess.name)

      @previous_number = previous_guess.previous_number
      @next_number = rand(101)

      until @next_number != @previous_number
        @next_number = rand(101)
      end

      if @higher
        @correct = @next_number > @previous_number
      else
        @correct = @next_number < @previous_number
      end

      previous_guess.next_number = @next_number
      previous_guess.guess = @guess
      previous_guess.correct = @correct

      previous_guess.save

      @winning_streak = determine_winning_streak(@name)
    end

    new_guess = create_guess(@name, @next_number, nil, nil, nil)
    puts(new_guess.name)
    new_guess.save
  end

  def guesses
    @guesses = Guess.order(created_at: :desc)
  end

  def create_guess(name, previous_number, next_number, guess, correct)
    new_guess = Guess.new
    new_guess.name = name
    new_guess.previous_number = previous_number
    new_guess.next_number = next_number
    new_guess.guess = guess
    new_guess.correct = correct
    new_guess
  end

  def determine_winning_streak(name)
    guesses = Guess.order(created_at: :desc).where(name: name)
    streak = 0

    guesses.each do |guess|
      unless guess.correct
        break
      end
      streak += 1
    end

    streak
  end
end
