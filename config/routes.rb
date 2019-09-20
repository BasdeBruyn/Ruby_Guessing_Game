Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'guess#index', as: 'guess'
  get 'guess_game' => 'guess#guess_game', as: 'guess_game'
  get 'guesses' => 'guess#guesses', as: 'guesses'
end
