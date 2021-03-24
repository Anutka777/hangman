# frozen_string_literal: true

# All display output
module Output
  def display_user_guess(user_guess)
    puts user_guess
    puts "\n\n"
  end

  def mes_enter_letter
    puts 'Enter letter'
  end

  def mes_game_over
    puts 'Game over'
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
    @tries = 7
    # @user_guess = Hash[@word_to_guess.map { |letter| [letter, '_'] }]
  end

  def chose_word_to_guess
    words_pull = []
    File.open('5desk.txt', 'r').readlines.each do |line|
      words_pull << line.chomp if line.chomp.length.between?(5, 12) &&
                                  line.count('[A-Z0-9_]').zero?
    end
    words_pull.sample.chars
  end

  def ask_letter
    mes_enter_letter
    input = gets.chomp.downcase until validate_user_input(input)
    p input
  end

  def validate_user_input(input)
    # input == 'p'
    input
  end

  def check_letter_in_word(word_to_guess, ask_letter)
    successful_check = 0
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
    p @user_guess
  end

  def out_of_tries?
    @tries <= 0
  end

  def word_was_guessed?
    @word_to_guess == @user_guess
  end

  def play
    until out_of_tries? || word_was_guessed?
      p @tries -= 1 if check_letter_in_word(word_to_guess, ask_letter).zero?
    end
    mes_game_over
  end
end

game = Game.new
p game.word_to_guess
p game.user_guess
game.play
