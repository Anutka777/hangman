# frozen_string_literal: true

require_relative 'game'
require 'yaml'

# Start a game
module Hangman
  def self.play
    case chose_new_or_saved_game
    when '0'
      game = Game.new
    when '1'
      game = load_game
    end
    game.play
  end

  def self.chose_new_or_saved_game
    puts 'Welcome to hangman'
    puts 'Enter 0 if you want to start a new game'
    puts 'Enter 1 if you want to load the previous game'
    input = gets.chomp until input =~ /[01]/
    input
  end

  def self.load_game
    if File.exist?('save.yaml')
      file = File.open('save.yaml', 'r')
      YAML.load(file)
    else
      puts 'No save file was found. Starting new game instead.'
      Game.new
    end
  end
end

Hangman.play
