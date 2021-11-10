require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @string = []
    10.times {
      @string << ('a'..'z').to_a.sample
    }
  end

  def score
    @answer = params[:answer].split('')
    # @start_letters = ActiveSupport::JSON.decode(params[:start_letters].to_json)
    @start_letters = params[:start_letters].split('')
    i = 0

    @answer.each do |letter|
      if @answer.count(letter) > @start_letters.count(letter)
        i += 1
      end
    end

    @json = {}
    if i.zero?
      url = "https://wagon-dictionary.herokuapp.com/#{@answer.join}"
      score_returned = URI.open(url).read
      @json = JSON.parse(score_returned)
    end

    if @json == {}
      @print = "Sorry but #{@answer.join} cannot be built out of #{@start_letters}"
    elsif @json["found"] == true
      @print = "Nice word #{@answer.join}! Your score is #{@json["length"].to_i * 1.8} "
    else
      @print = "#{@answer.join} is not a word! Please try again"
    end
  end
end
