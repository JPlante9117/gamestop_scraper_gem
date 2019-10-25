class GamestopScraper::CLI

    def run
        puts "                      Welcome to GameStop!                 "
        puts "      Take a look at the newest games, or upcoming releases! "
        puts " "
        puts "   Please type 'new games' to see a list the top 6 new games,"
        puts "  or 'upcoming games' to  see the top 6 games releasing soon!"
        puts "    You may at any time type exit to close out the program. "
        puts "  -----------------------------------------------------------"
        GamestopScraper::Scraper.scrape_game
        
        menu
    end

    def menu
        input = nil
        while input != 'exit'
            input = gets.strip.downcase
            case input
            when 'new games'
                puts " "
                puts "Here's a list of the hottest"
                puts "         new games          "
                puts "----------------------------"
                puts " "
                print_new_games
                puts " "
                puts "Select a number to see more details on that game, or say 'menu' to return to the menu."
                puts " "
                #input = gets.strip.downcase
            when 'upcoming games'
                puts " "
                puts "Here's a list of the most anticipated"
                puts "          upcoming releases          "
                puts "-------------------------------------"
                puts " "
                print_upcoming_games
                puts " "
                puts "Select a number to see more details on that game, or say 'menu' to return to the menu."
                puts " "
                #input = gets.strip.downcase
            when 'commands'
                puts " "
                puts "   Please type 'new games' to see a list of new games,"
                puts "  or 'upcoming games' to  see the games releasing soon!"
                puts " You may at any time type exit to close out the program. "
                puts " "
            when 'exit'
                break
            else
                puts " "
                puts "Please enter a valid command, or enter 'commands' to see a list of commands."
                puts " "
            end
        end
    end

    def print_new_games
        GamestopScraper::Game.new_games.each.with_index(1) { |game, index| puts "#{index}. #{game.title}"}
    end

    def print_upcoming_games
        GamestopScraper::Game.upcoming_releases.each.with_index(1) { |game, index| puts "#{index}. #{game.title}"}
    end

end