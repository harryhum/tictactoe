class Game
    attr_accessor :player
    attr_reader :grid

    def initialize(player_one, player_two)
        @player_one = Player.new(player_one)
        @player_two = Player.new(player_two)
        @grid = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
    end

    class Player
        attr_accessor :name, :sign, :turn

        def initialize(name)
            @name = name
        end
    end

    def start
        rand_player
        starting_player = @player_one.turn == true ? @player_one : @player_two
        second_player = @player_one.turn == false ? @player_one : @player_two
        starting_player.sign = 'x' 
        second_player.sign = 'o'
        puts "#{starting_player.name} is X and #{second_player.name} is O.\n#{starting_player.name} goes first."
        make_move
    end

    def display_grid
        puts "Grid:"
        puts "    0    1    2"
        puts "0 #{@grid[0].inspect}"
        puts "1 #{@grid[1].inspect}"
        puts "2 #{@grid[2].inspect}"
    end

    def rand_player
        @player_one.turn = rand > 0.5 ? true : false
        @player_two.turn = @player_one.turn == false ? true : false
    end

    def make_move
        display_grid
        @current_player = @player_one.turn == true ? @player_one : @player_two
        puts "#{@current_player.name}, make your move"
        get_coordinates
    end
    
    def get_coordinates
        puts "Enter row number:"
        row_num = gets.chomp.to_i
        puts "Enter column number:"
        column_num = gets.chomp.to_i
        write_in_grid(row_num, column_num)
    end

    def write_in_grid(row, column)
        @grid[row][column] = @current_player.sign
        display_grid
        switch_turns
        make_move
    end

    def switch_turns
        @player_one.turn, @player_two.turn = @player_two.turn, @player_one.turn
    end

end

#New game with player_one and player_two
game_one = Game.new('Harry', 'Kaia')

#Start game by seeing who gets which sign and who goes first
game_one.start