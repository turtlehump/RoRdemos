load "#{Rails.root}/lib/ladder.rb"

class HomeController < ApplicationController

  def index
    begin
      @start_word = dictionary.sample
      @end_word = dictionary.sample
    end while(@start_word == @end_word)
  end

  def show
    @guesses = [params[:word1], params[:word2], params[:word3], params[:word4], params[:word5]]
    @guesses.each_with_index { |word, i| @guesses[i] = nil if word == ""}.compact!
    @start_word = params["start_word"]
    @end_word = params["end_word"]
    @word_ladder = [params[:start_word], params[:word1], params[:word2], params[:word3], params[:word4], params[:word5], params[:end_word]]
    @legal = legal @word_ladder
  end

end
