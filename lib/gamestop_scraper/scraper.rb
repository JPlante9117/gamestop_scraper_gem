class GamestopScraper::Scraper

    def self.scrape_game
        puts "scraping main . . ."
        html = open("https://www.gamestop.com/")
        doc = Nokogiri::HTML(html)
        i = 0
        doc.css("div.row.key-art-carousel")[0].css(".slide").each do |game|
            #binding.pry
            new_game = GamestopScraper::Game.new
            new_game.title = game.css("a").css(".font-bold").text.strip
            new_game.url = game.css("a").attribute("href").value
            unless new_game.url.include?("/video-games/")
                if new_game.url.include?("/collection/")
                    url_name = CGI::escape(new_game.title).gsub(/[.,\/#!$%\^&\*;:{}=\-_`~()]/,"")                   
                    html = open("https://www.gamestop.com/search/?q=#{url_name}&lang=default")
                    doc = Nokogiri::HTML(html)
                    new_game.url = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[0].css("a").attribute("href").value
                else
                    html = open("https://www.gamestop.com#{new_game.url}")
                    doc = Nokogiri::HTML(html)
                    new_game.url = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[0].css("a").attribute("href").value
                end
               
            end
            
            GamestopScraper::Game.new_games << new_game
        end
        
        html = open("https://www.gamestop.com/")
        doc = Nokogiri::HTML(html)
        doc.css("div.row.key-art-carousel")[1].css(".slide").each do |game|
            upcoming_release = GamestopScraper::Game.new
            upcoming_release.url = game.css("a").attribute("href").value
            upcoming_release.title = game.css("a").css(".font-bold").text.strip
            unless upcoming_release.url.include?("/video-games/")
                if upcoming_release.url.include?("/collection/")
                    url_name = CGI::escape(upcoming_release.title).gsub(/[.,\/#!$%\^&\*;:{}=\-_`~()]/,"")
                    html = open("https://www.gamestop.com/search/?q=#{url_name}&lang=default")
                    doc = Nokogiri::HTML(open(html))
                    upcoming_release.url = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[0].css("a").attribute("href").value
                else
                    html = open("https://www.gamestop.com#{upcoming_release.url}")
                    doc = Nokogiri::HTML(html)
                    upcoming_release.url = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[0].css("a").attribute("href").value
                end
               
            end
            GamestopScraper::Game.upcoming_releases << upcoming_release
        end
        puts "done scraping main!"
    end

    def self.scrape_game_details(game)
        puts "scraping details . . ."
        html = open("https://www.gamestop.com#{game.url}")
        doc = Nokogiri::HTML(html)
        # binding.pry
        game.publisher = doc.css(".product-publisher .pr-1")[0].text.strip
        game.esrb = doc.css(".product-name-section").children[3].css("img").attribute("alt").value
        game.release_date = doc.css(".product-publisher .pdp-release-date")[1].text.strip.gsub("Release Date: ", "")
        game.rating = doc.css("div.tab-pane").children[13].children[5].children[3].children[0].text.strip
        game.platforms = []
        doc.css("select.custom-select")[0].css("option").each do |systems|
            game.platforms << systems.text.strip
        end
        game.price = doc.css("span.value")[0].text.strip
        game.description = doc.css(".product-info")[0].css(".short-description").text.strip
        puts "done scraping!"
    end
    
end