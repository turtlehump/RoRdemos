load "#{Rails.root}/lib/ladder.rb"

class HomeController < ApplicationController

  def index
    begin
      @start_word = dictionary.sample
      @end_word = dictionary.sample
    end while(@start_word == @end_word)
  end

  def show
    @words = Array.new
    @words.push(params[:word1])
    @words.push(params[:word2])
    @words.push(params[:word3])
    @words.push(params[:word4])
    @words.push(params[:word5])
    @words.delete_if { |a| a == ""}
    @start_word = params["start_word"]
    @end_word = params["end_word"]
  end

end
