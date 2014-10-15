require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class NPRScraper
  URL = "http://www.npr.org/sections/news/"
  attr_accessor :url, :nokogiri_doc, :articles
  def initialize
    @url = URL
    @nokogiri_doc = Nokogiri::HTML(open(url))
    @articles = []
  end

  def featured_titles
    featured_titles = nokogiri_doc.css('div#featured h1.title a')
    featured_titles.each_with_index do |item, index|
      name = item.text
      #binding.pry
      url = item.attributes["href"].value
      @articles << Article.new(name, url)
      puts "#{index+1}. #{name}"
    end
  end
end

class Article
  attr_accessor :name, :teaser, :url, :articles

  @@articles = []
  def initialize(name, url)
    @name = name
    @url = url
    @@articles << self if !@@articles.include?(self)
  end

end

# scraper = NPRScraper.new
# page = scraper.nokogiri_doc
# p page
# binding.pry