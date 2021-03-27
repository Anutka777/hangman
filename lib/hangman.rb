# frozen_string_literal: true

require_relative 'game'
require 'yaml'

# Start a game
module Hangman
  def self.play
    puts 'Enter 0 if you want to start a new game'
    puts 'Enter 1 if you want to load the previous game'
    input = gets.chomp until input =~ /[01]/
    case input
    when '0'
      game = Game.new
    when '1'
      if File.exist?('save.yaml')
        file = File.open('save.yaml', 'r')
        game = YAML.load(file)
      else
        puts 'No save file was found. Starting new game instead.'
        game = Game.new
      end
    end
    game.play
  end
end

Hangman.play
