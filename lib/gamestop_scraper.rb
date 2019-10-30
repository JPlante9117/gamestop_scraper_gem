require_relative "./gamestop_scraper/version"

module GamestopScraper
  class Error < StandardError; end
  # Your code goes here...
end

require 'bundler/setup'
Bundler.require

require 'open-uri'

require_relative './gamestop_scraper/cli'
require_relative './gamestop_scraper/game'
require_relative './gamestop_scraper/scraper'