class GamestopScraper::Scraper

    def self.scrape_game
        html = open("https://www.gamestop.com/")
        doc = Nokogiri::HTML(html)
        i = 0
        doc.css("div.row.key-art-carousel")[0].css(".slide").each do |game|
            #binding.pry
            new_game = GamestopScraper::Game.new
            new_game.url = game.css("a").attribute("href").value
            new_game.title = game.css("a").css(".font-bold").text.strip
            GamestopScraper::Game.new_games << new_game
        end

        doc.css("div.row.key-art-carousel")[1].css(".slide").each do |game|
            #binding.pry
            upcoming_release = GamestopScraper::Game.new
            upcoming_release.url = game.css("a").attribute("href").value
            upcoming_release.title = game.css("a").css(".font-bold").text.strip
            GamestopScraper::Game.upcoming_releases << upcoming_release
        end

    end

    def self.scrape_game_details(game)

    end

end