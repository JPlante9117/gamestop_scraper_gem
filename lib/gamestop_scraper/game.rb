class GamestopScraper::Game

    attr_accessor :title, :url, :publisher, :rating, :platforms, :price, :description, :release_date, :esrb

    @@all = []
    @@new_games = []
    @@upcoming_releases = []

    def initialize
        @@all << self
        @platforms = []
    end

    def self.all
        @@all
    end

    def self.new_games
        @@new_games
    end

    def self.upcoming_releases
        @@upcoming_releases
    end

end