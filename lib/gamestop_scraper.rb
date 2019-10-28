require_relative "./gamestop_scraper/version"

module GamestopScraper
  class Error < StandardError; end
  # Your code goes here...
end

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'webrick'

require_relative './gamestop_scraper/cli'
require_relative './gamestop_scraper/game'
require_relative './gamestop_scraper/scraper'