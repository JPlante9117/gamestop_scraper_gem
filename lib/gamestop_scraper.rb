require "gamestop_scraper/version"

module GamestopScraper
  class Error < StandardError; end
  # Your code goes here...
end

require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './lib/cli'
require_relative './lib/game'
require_relative './lib/scraper'