class GamestopScraper::CLI

    attr_accessor :game, :input

    def run
        GamestopScraper::Scraper.scrape_game
        
        menu
    end

    def menu
        puts "                      Welcome to ".colorize(:yellow) + "Game".colorize(:red) + "Stop".colorize(:white) + "!                 ".colorize(:yellow)
        puts "      Take a look at the newest games, or upcoming releases! ".colorize(:yellow)
        puts " "
        puts "   Please type ".colorize(:yellow) + "'ng'".colorize(:light_blue) + " to see a list the top 6 new games,".colorize(:yellow)
        puts "  or ".colorize(:yellow) + "'ug'".colorize(:light_blue) + " to  see the top 6 games releasing soon!".colorize(:yellow)
        puts "    You may at any time type ".colorize(:yellow) + "'exit'".colorize(:light_red) + " to close out the program. ".colorize(:yellow)
        puts "  -----------------------------------------------------------".colorize(:yellow)
        @input = nil
        while @input != 'exit' do
            @input = gets.strip.downcase
            case @input
            when 'ng'
                @game = nil
                puts " "
                puts "Here's a list of the hottest".colorize(:yellow)
                puts "         new games          ".colorize(:yellow)
                puts "----------------------------".colorize(:yellow)
                puts " "
                print_new_games
                select_game_details
                while @input != 'exit' do
                    @input = gets.strip.downcase
                    case
                    when (@input.to_i > 0 && @input.to_i <= GamestopScraper::Game.new_games.length)
                        detail_results(GamestopScraper::Game.new_games)
                    when @input == 'menu'
                        menu
                    when @input == 'd'
                        game_description
                    when @input == 'exit'
                        break
                    when @input == 'commands'
                        commands_detail("ng")
                    else
                        error_handler
                    end
                end
            when 'ug'
                @game = nil
                puts " "
                puts "Here's a list of the most anticipated".colorize(:yellow)
                puts "          upcoming releases          ".colorize(:yellow)
                puts "-------------------------------------".colorize(:yellow)
                puts " "
                print_upcoming_games
                select_game_details
                while @input != 'exit' do
                    @input = gets.strip.downcase
                    case 
                    when (@input.to_i > 0 && @input.to_i <= GamestopScraper::Game.upcoming_releases.length)
                        detail_results(GamestopScraper::Game.upcoming_releases)
                    when @input == 'menu'
                        menu
                    when @input == 'd'
                        game_description
                    when @input == 'exit'
                        break
                    when @input == 'commands'
                        commands_detail("ug")
                    else
                        error_handler
                    end
                end
            when 'commands'
                commands_menu
            when 'exit'
                break
            else
                error_handler
            end
        end
    end

    def print_new_games
        GamestopScraper::Game.new_games.each.with_index(1) { |game, index| puts "#{index}.".colorize(:light_blue) + " #{game.title}".colorize(:yellow)}
    end

    def print_upcoming_games
        GamestopScraper::Game.upcoming_releases.each.with_index(1) { |game, index| puts "#{index}.".colorize(:light_blue) + " #{game.title}".colorize(:yellow)}
    end

    def error_handler
        puts " "
        puts "Please enter a valid command, or type ".colorize(:yellow) + "'commands'".colorize(:light_blue) + " to see a list of commands!".colorize(:yellow)
        puts " "
    end
    
    def commands_menu
        puts " "
        puts "   Please type ".colorize(:yellow) + "'new games'".colorize(:light_blue) + " to see a list of new games,".colorize(:yellow)
        puts "  or ".colorize(:yellow) + "'upcoming games'".colorize(:light_blue) + " to  see the games releasing soon!".colorize(:yellow)
        puts " You may at any time type ".colorize(:yellow) + "'exit'".colorize(:light_red) + " to close out the program. ".colorize(:yellow)
        puts " "
    end

    def commands_detail(section)
        if section == "ng"
            array = GamestopScraper::Game.new_games
            blurb = "a new game"
        elsif section == "ug"
            array = GamestopScraper::Game.upcoming_releases
            blurb = "an upcoming release"
        end
        puts " "
        puts "  Type a number ".colorize(:yellow) + "(1-#{array.length})".colorize(:light_blue) + " to see #{blurb}!".colorize(:yellow)
        puts "If you have already selected a game, type ".colorize(:yellow) + "'description'".colorize(:light_blue) + "!".colorize(:yellow)
        puts "    to receive a short description of that game!".colorize(:yellow)
        puts "  Or, you may type ".colorize(:yellow) + "'menu'".colorize(:light_blue) + " to return to the main menu.".colorize(:yellow)
        puts " "
    end

    def select_game_details
        puts " "
        puts "Select a number to see more details on that game, ".colorize(:yellow)
        puts "       'menu'".colorize(:light_blue) + " to return to the menu, ".colorize(:yellow)
        puts "     or type ".colorize(:yellow) + "'exit'".colorize(:light_red) + " to close the program.".colorize(:yellow)
        puts " "
    end

    def game_description
        if @game
            puts " "
            puts game.description.colorize(:light_green)
            commands_detail
            
        else
            puts " "
            puts "Please select a game first.".colorize(:yellow)
            puts " "
        end
    end

    def detail_results(array)
        @game = array[@input.to_i - 1]
        GamestopScraper::Scraper.scrape_game_details(@game) if !game.esrb
        puts "Title: ".colorize(:light_blue) + @game.title.colorize(:light_cyan)
        unless @game.publisher == ""
            puts ("Publisher: ".colorize(:light_blue) + @game.publisher.colorize(:light_cyan))
        end
        unless @game.release_date == ""
            puts ("Release Date: ".colorize(:light_blue) + @game.release_date.colorize(:light_cyan))
        end
        puts "ESRB Rating: ".colorize(:light_blue) + @game.esrb.colorize(:light_cyan)
        puts "Available On: ".colorize(:light_blue) + @game.platforms.uniq.sort.join(", ").colorize(:light_cyan)
        puts "Price: ".colorize(:light_blue) + @game.price.colorize(:light_cyan)
        puts " "
        puts "You can request a short description of the game with ".colorize(:yellow) + "'d'".colorize(:light_blue) + "!".colorize(:yellow)
        puts " "
        puts "Otherwise, for another title, enter another number, or type ".colorize(:yellow) + "'menu'".colorize(:light_blue) + " to return to the menu.".colorize(:yellow)
        puts " "
    end

end