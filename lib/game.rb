# frozen_string_literal: true

require 'yaml'

# All display output
module Output
  def display_user_guess(user_guess)
    puts user_guess.join(' ')
    puts ''
  end

  def display_user_letter_picks
    puts "Letters you already picked: #{@user_letter_picks.join(', ')}"
  end

  def mes_start
    puts 'Start game'
  end

  def mes_enter_letter
    puts 'Enter letter'
  end

  def mes_no_such_letter
    puts "\e[31mNo such letter\e[0m"
    puts "\e[31mTries left: #{@tries}\e[0m"
    puts ''
  end

  def mes_game_over
    puts 'Game over'
  end

  def mes_win
    puts 'You guessed right and won the game!'
  end
end

# To handle game flow
class Game
  include Output
  attr_reader :word_to_guess
  attr_accessor :user_guess

  def initialize
    @word_to_guess = chose_word_to_guess
    @user_guess = Array.new(@word_to_guess.length, '_')
    @user_letter_picks = []
    @tries = 12
  end

  def chose_word_to_guess
    words_pool = []
    File.open('5desk.txt', 'r').readlines.each do |line|
      words_pool << line.chomp if line.chomp.length.between?(5, 12) &&
                                  line.count('[A-Z0-9_]').zero?
    end
    words_pool.sample.chars
  end

  def ask_letter
    display_user_letter_picks
    # mes_enter_letter
    input = gets.chomp.downcase until validate_user_guess_input(input)
    input
  end

  def validate_user_guess_input(input)
    if input.nil?
      mes_enter_letter
    elsif input == 'save'
      save_game
    elsif input !~ /^[a-z]$/
      puts 'Check your input. It should be a single letter.'
    elsif @user_letter_picks.include?(input)
      puts 'You already picked this letter. Choose another one.'
    else
      @user_letter_picks << input
    end
  end

  def check_letter_in_word(word_to_guess, ask_letter)
    successful_check = 0
    successful_check += 1 if ask_letter == 'save'
    word_to_guess.each_with_index do |letter, index|
      if ask_letter == letter
        @user_guess = update_user_guess(letter, index)
        successful_check += 1
      end
    end
    successful_check
  end

  def update_user_guess(letter, index)
    @user_guess[index] = letter
    @user_guess
  end

  def out_of_tries?
    @tries <= 0
  end

  def word_was_guessed?
    @word_to_guess == @user_guess
  end

  def save_game
    saved_state = YAML.dump(self)
    p saved_state
    File.open('/home/anna/Документы/Programming/Ruby/hangman/save.yaml', 'w') do |file|
      file.puts saved_state
    end
  end

  def play
    mes_start
    until out_of_tries?
      break mes_win if word_was_guessed?

      display_user_guess(user_guess)
      sleep 1
      if check_letter_in_word(word_to_guess, ask_letter).zero?
        @tries -= 1
        mes_no_such_letter
      end
    end
    mes_game_over
  end
end

game = Game.new
p game.word_to_guess
game.play
