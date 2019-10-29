class GamestopScraper::Scraper

    def self.scrape_game
        puts "scraping main . . ."
        html = open("https://www.gamestop.com/")
        doc = Nokogiri::HTML(html)
        i = 0
        doc.css("div.row.key-art-carousel")[0].css(".slide").each do |game|
            new_game = GamestopScraper::Game.new
            new_game.title = game.css("a").css(".font-bold").text.strip
            new_game.url = game.css("a").attribute("href").value
            GamestopScraper::Game.new_games << new_game
        end
        
        html = open("https://www.gamestop.com/")
        doc = Nokogiri::HTML(html)
        doc.css("div.row.key-art-carousel")[1].css(".slide").each do |game|
            upcoming_release = GamestopScraper::Game.new
            upcoming_release.url = game.css("a").attribute("href").value
            upcoming_release.title = game.css("a").css(".font-bold").text.strip
            GamestopScraper::Game.upcoming_releases << upcoming_release
        end
        puts "done scraping main!"
    end

    def self.scrape_game_details(game)
        puts "scraping details . . ."
        unless game.url.include?("/video-games/")
            if game.url.include?("/collection/")
                url_name = CGI::escape(game.title).gsub(/[.,\/#!$%\^&\*;:{}=\-_`~()]/,"")
                html = open("https://www.gamestop.com/search/?q=#{url_name}&lang=default")
                doc = Nokogiri::HTML(open(html))
            else
                html = open("https://www.gamestop.com#{game.url}")
                doc = Nokogiri::HTML(html)
            end
            i = 0
            search_css = ""
            while search_css.casecmp(game.title) != 0
                binding.pry
                i += 1
                search_css = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[i].css("img").attribute("alt").value.strip
            end
            game.url = doc.css(".tab-pane .row .product-grid-wrapper .row .product-grid-tile-wrapper")[i].css("a").attribute("href").value
           
        end
        html = open("https://www.gamestop.com#{game.url}")
        doc = Nokogiri::HTML(html)
        game.publisher = doc.css(".product-publisher .pr-1")[0].text.strip unless doc.css(".product-publisher .pr-1")[0] == nil
        game.esrb = doc.css(".product-name-section").children[3].css("img").attribute("alt").value
        game.release_date = doc.css(".product-publisher .pdp-release-date")[1].text.strip.gsub("Release Date: ", "")
        if doc.css("select.select-platform")[0]
            doc.css("select.select-platform")[0].css("option").each do |systems|
               if systems.text.strip == "Nintendo Switch"
               game.platforms << "Switch" unless game.platforms.include?("Switch")
               else
               game.platforms << systems.text.strip unless game.platforms.include?(systems.text.strip)
               end
            end
        else
            game.platforms << doc.css("ol.breadcrumb").children[5].children.text.strip
        end
        game.price = doc.css("span.value")[0].text.strip
        game.description = doc.css(".product-info")[0].css(".short-description").text.strip
        puts "done scraping!"
    end
    
end