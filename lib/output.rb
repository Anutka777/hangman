# frozen_string_literal: true

# All display output
module Output
  # private

  def display_user_guess(user_guess)
    puts user_guess.join(' ')
    puts ''
  end

  def display_user_letter_picks
    puts "Letters you already picked: #{user_letter_picks.join(', ')}"
  end

  def mes_enter_letter
    puts 'Enter letter'
  end

  def mes_no_such_letter
    puts "\e[31mNo such letter\e[0m"
    puts "\e[31mTries left: #{tries}\e[0m"
    puts ''
  end

  def mes_game_over
    puts 'Game over'
  end

  def mes_win
    puts 'You guessed right and won the game!'
  end
end
