class GuessController < ApplicationController
  def index
  end

  def guess_game
    guess = params[:guess]
    name = params[:name]

    name ||= guess[:name]
    
    @guess_page = GuessService.create_guess_page(guess, name)
  end

  def guesses
    @guesses = GuessService.retrieve_guesses
  end
end
