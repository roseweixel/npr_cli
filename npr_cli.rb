require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'time'
require 'launchy'
require_relative 'npr_scraper'

class NPRCLI
  SCRAPER = NPRScraper.new
  def greet
    puts "Welcome to your command line interface for getting the latest news from NPR. Today is #{Date.today}."
  end

  def help
    puts "I accept the following commands:"
    puts "- list featured"
    puts "- list all"
    puts "- exit"
  end

  def list_featured
    SCRAPER.featured_titles
  end

  def list_all

  end

  def exit
    puts "♥ This NPR news cli was made with love at The Flatiron School by Rose Weixel ♥"
  end

  def get_full_article(choice)
    chosen_article = SCRAPER.articles.find{|article| article.name.downcase.include?(choice.downcase.strip)}
    Launchy.open(chosen_article.url) if chosen_article
  end

  def call
    greet
    help
    command = ""
    while command != "exit"
      puts "Please enter a command."
      command = gets.strip.downcase
      case command
      when "exit"
        exit
      when "list featured"
        list_featured
        puts "To view one of these articles, enter the at least the first three words of the title below, or just hit enter to return to the main menu."
        response = gets.strip.downcase
        get_full_article(response) if response.length > 10
      when "list all"
        list_featured
        puts "More articles coming soon!"
      when "help"
        help
      end
    end
  end
end

cli = NPRCLI.new
cli.call