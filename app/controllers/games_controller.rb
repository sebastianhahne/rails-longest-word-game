require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @letters = (0...10).map { (65 + rand(26)).chr }
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @answer = params[:answer].upcase
    @api_call = english_word?
    @include = included?
  end

  private

  def included?
    @answer.chars.all? do |letter|
      @answer.count(letter) <= @letters.count(letter)
    end
  end

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    json = JSON.parse(response.read)
    json['found']
  end
end
