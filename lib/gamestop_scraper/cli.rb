class GamestopScraper::CLI

    def run
        puts "                 Welcome to GameStop!                 "
        puts " Take a look at the newest games, or upcoming releases! "
        puts " "
        puts "   Please type 'new games' to see a list of new games,"
        puts "  or 'upcoming games' to  see the games releasing soon!"
        puts " You may at any time type exit to close out the program. "
        puts "------------------------------------------------------------"

        input = nil
        while input != 'exit'
            input = gets.strip.downcase
            case input
            when 'new games'
                puts " "
                puts "Here's a list of new games"
                puts "--------------------------"
                puts " "
                puts "list here"
                puts " "
                puts "Select a number to see more details on that game, or say 'menu' to return to the menu."
                puts " "
                #input = gets.strip.downcase
            when 'upcoming games'
                puts " "
                puts "Here's a list of upcoming releases"
                puts "----------------------------------"
                puts " "
                puts "List here"
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
            when 'menu'
                run
            when 'exit'
                break
            else
                "Please enter a valid command, or enter 'commands' to see a list of commands."
            end
        end
    end

end