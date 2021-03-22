# frozen_string_literal: true

# To handle game flow
class Game
  def chose_word_to_guess
    words_pull = []
    File.open('5desk.txt', 'r').readlines.each do |line|
      words_pull << line.chomp if line.chomp.length.between?(5, 12) &&
                                  line.count('[A-Z0-9_]').zero?
    end
    p words_pull.sample
  end
end

Game.new.chose_word_to_guess
