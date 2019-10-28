class GamestopScraper::CLI

    def run
        GamestopScraper::Scraper.scrape_game
        
        menu
    end

    def menu
        puts "                      Welcome to GameStop!                 "
        puts "      Take a look at the newest games, or upcoming releases! "
        puts " "
        puts "   Please type 'new games' to see a list the top 6 new games,"
        puts "  or 'upcoming games' to  see the top 6 games releasing soon!"
        puts "    You may at any time type exit to close out the program. "
        puts "  -----------------------------------------------------------"
        input = nil
        while input != 'exit' do
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
                puts "Select a number to see more details on that game, "
                puts "     or say 'exit' to close the program."
                puts " "
                while input != 'exit' do
                    input = gets.strip.downcase
                    case input
                    when '1','2','3','4','5','6'
                        game = GamestopScraper::Game.new_games[input.to_i - 1]
                        GamestopScraper::Scraper.scrape_game_details(game) if !game.publisher
                        # binding.pry
                        puts "Title: #{game.title}"
                        puts "Publisher: #{game.publisher}"
                        puts "ESRB Rating: #{game.esrb}"
                        # puts "Review Rating: #{game.rating}"
                        puts "Available On: #{game.platforms.uniq.join(", ")}"
                        puts "Price: #{game.price}"
                        puts " "
                        puts "You can request a short description of the game with 'description'!"
                        puts " "
                        puts "Otherwise, for another title, enter another number, or type 'menu' to return to the menu."
                        puts " "
                    when 'menu'
                        menu
                    when 'description'
                        if game
                            puts " "
                            puts "#{game.description}"
                            puts " "
                        else
                            puts " "
                            puts "Please select a game first."
                            puts " "
                        end
                    when 'exit'
                        break
                    when 'commands'
                        puts " "
                        puts "  Type a number (1-6) to see a newly released game"
                        puts "If you have already selected a game, type 'description'"
                        puts "    to receive a short description of that game!"
                        puts "  Or, you may type 'menu' to return to the main menu."
                        puts " "
                    else
                        puts " "
                        puts "Please enter a valid command, or type 'commands' to see a list of commands!"
                        puts " "
                    end
                end
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
                while input != 'exit' do
                    input = gets.strip.downcase
                    game = nil
                    case input
                    when '1', '2', '3', '4', '5', '6'
                        game = GamestopScraper::Game.upcoming_releases[input.to_i - 1]
                        GamestopScraper::Scraper.scrape_game_details(game) if !game.publisher
                        # binding.pry
                        puts "Title: #{game.title}"
                        puts "Publisher: #{game.publisher}" unless game.publisher == nil
                        puts "Release Date: #{game.release_date}" unless game.release_date == nil
                        puts "ESRB Rating: #{game.esrb}" unless game.esrb == nil
                        # puts "Review Rating: #{game.rating}"
                        puts "Available On: #{game.platforms.uniq.join(", ")}"
                        puts "Price: #{game.price}"
                        puts " "
                        puts "You can request a short description of the game with 'description'!"
                        puts " "
                        puts "Otherwise, for another title, enter another number, or type 'menu' to return to the menu."
                        puts " "
                    when 'menu'
                        menu
                    when 'description'
                        if game
                            puts " "
                            puts "#{game.description}"
                            puts " "
                        else
                            puts " "
                            puts "Please select a game first."
                            puts " "
                        end
                    when 'exit'
                        break
                    when 'commands'
                        puts " "
                        puts "  Type a number (1-6) to see a newly released game"
                        puts "If you have already selected a game, type 'description'"
                        puts "    to receive a short description of that game!"
                        puts "  Or, you may type 'menu' to return to the main menu."
                        puts " "
                    else
                        puts " "
                        puts "Please enter a valid command, or type 'commands' to see a list of commands!"
                        puts " "
                    end
                end
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