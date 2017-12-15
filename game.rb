class Game
    attr_reader :win, :tie

    def initialize
        @player_one = Player.new(1)
        @player_two = Player.new(2)
        @current_player = nil
    end

    def win
        @win
    end

    def tie
        @tie
    end

    class Player
        attr_accessor :name, :sign
        
        def initialize(player_number)
            puts "Player #{player_number}, enter your name:"
            @name = gets.chomp
        end
    end

    def set
        @board = {a1: " ", a2: " ", a3: " ",
                  b1: " ", b2: " ", b3: " ",
                  c1: " ", c2: " ", c3: " "}
        @moves = 0
        @win = false
        @tie = false
    end

    def assign_signs
        @players = [@player_one, @player_two]
        signs = rand < 0.5 ? ['x', 'o'] : ['o', 'x']
        @player_one.sign, @player_two.sign = signs[0], signs[1]
        puts "#{@player_one.name} is #{@player_one.sign.upcase} and #{@player_two.name} is #{@player_two.sign.upcase}."
    end

    def who_goes_first?
        puts 'Simulated rock, paper, scissors to see who goes first...'
        @current_player = @players[rand.round]
        sleep(2)
        puts "#{@current_player.name} goes first."
    end

    def display
        puts "Board:"
        puts "    1   2   3"
        puts "a  [#{@board[:a1]}] [#{@board[:a2]}] [#{@board[:a3]}]"
        puts "b  [#{@board[:b1]}] [#{@board[:b2]}] [#{@board[:b3]}]"
        puts "c  [#{@board[:c1]}] [#{@board[:c2]}] [#{@board[:c3]}]"
    end

    def get_coordinates
        puts "Enter row letter:"
        row_letter = gets.chomp
        while not row_letter.between?('a', 'c') && row_letter.length == 1
            puts "Please enter a valid row letter!"
            row_letter = gets.chomp
        end
        puts "Enter column number:"
        column_num = gets.chomp.to_i
        while not column_num.between?(1, 3)
            puts "Please enter a valid column number!"
            column_num = gets.chomp.to_i
        end
        @coordinates = row_letter + column_num.to_s
    end

    def write_in_board
        if @board[@coordinates.to_sym] == ' '
            @moves += 1
            @board[@coordinates.to_sym] = @current_player.sign
        else 
            puts 'That cell has already been taken!'
            get_coordinates
            write_in_board
        end
    end

    def switch_turns
        @current_player = @current_player == @player_one ? @player_two : @player_one
    end

    def win?
        win_x = ['x', 'x', 'x']
        win_o = ['o', 'o', 'o']

        winning_combos = 
            [[@board[:a1], @board[:a2], @board[:a3]],
             [@board[:b1], @board[:b2], @board[:b3]],
             [@board[:c1], @board[:c2], @board[:c3]],
             [@board[:a1], @board[:b2], @board[:c3]],
             [@board[:a3], @board[:b2], @board[:c1]],
             [@board[:a1], @board[:b1], @board[:c1]],
             [@board[:a2], @board[:b2], @board[:c2]],
             [@board[:a3], @board[:b3], @board[:c3]],]

        winning_combos.each do |combo|
            if combo == win_x || combo == win_o
                @win = true
                puts "#{@current_player.name} wins!"
            end
        end 
    end

    def tie?
        @tie = @moves >= 9 && @win == false ? true : false
        if @tie
            puts "It's a tie!"
        end
    end
end

game = Game.new

while true do
    game.set
    game.assign_signs
    game.who_goes_first?
    game.display

    until game.win || game.tie do
        game.get_coordinates
        game.write_in_board
        game.display
        game.win?
        game.tie?
        game.switch_turns
    end

    puts "Play again? (y/n)"
    play_again = gets.chomp
    if play_again == 'n'
        exit
    end
end
