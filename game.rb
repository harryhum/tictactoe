#To do: 
    #Separate grid into subclass?
    #Separate methods into smaller chunks
    #Make methods private

class Game
    attr_accessor :player
    attr_reader :grid

    def initialize
        name_entry
    end

    class Player
        attr_accessor :name, :sign, :turn

        def initialize(name)
            @name = name
        end
    end

    def name_entry
        puts "Player 1 enter your name:"
        player_one_name = gets.chomp
        puts "Player 2 enter your name:"
        player_two_name = gets.chomp
        @player_one = Player.new(player_one_name)
        @player_two = Player.new(player_two_name)
        start
    end

    def start
        @grid = [[' ', ' ', ' '], [' ', ' ', ' '], [' ', ' ', ' ']]
        rand_player
        @player_x = @player_one.turn == true ? @player_one : @player_two
        @player_o = @player_one.turn == false ? @player_one : @player_two
        @player_x.sign = 'x' 
        @player_o.sign = 'o'
        puts "#{@player_x.name} is X and #{@player_o.name} is O.\n#{@player_x.name} goes first."
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
        while not row_num.between?(0, 2)
            puts "Please enter a valid row number!"
            row_num = gets.chomp.to_i
        end
        puts "Enter column number:"
        column_num = gets.chomp.to_i
        while not column_num.between?(0, 2)
            puts "Please enter a valid column number!"
            column_num = gets.chomp.to_i
        end
        write_in_grid(row_num, column_num)
    end

    def write_in_grid(row, column)
        if cell_blank?(row, column)
            @grid[row][column] = @current_player.sign
        else
            display_grid
            puts "#{@current_player.name}, the square is already occupied! Please enter the coordinates of a blank square."
            get_coordinates
        end
        display_grid
        win?(row, column)
        switch_turns
        make_move
    end

    def switch_turns
        @player_one.turn, @player_two.turn = @player_two.turn, @player_one.turn
    end

    def cell_blank?(row, column)
        @grid[row][column] == ' ' ? true : false
    end

    def win?(row, column)
        if three_in_a_row?(row) || three_in_a_column?(column) || three_in_a_diagonal?
            puts "#{@grid[row][column] == @player_one.sign ? @player_one.name : @player_two.name} wins! Game over, play again? (Enter y/n)"
            play_again = gets.chomp
            play_again == 'y' ? start : exit
        end
    end

    def three_in_a_row?(row_num)
        if cell_blank?(row_num, 0) || cell_blank?(row_num, 1) || cell_blank?(row_num, 2)
            false
        else
            if @grid[row_num][0] == @grid[row_num][1] && @grid[row_num][0] == @grid[row_num][2]
                true
            else
                false
            end
        end
    end

    def three_in_a_column?(column_num)
        if cell_blank?(0, column_num) || cell_blank?(1, column_num) || cell_blank?(2, column_num)
            false
        else
            if @grid[0][column_num] == @grid[1][column_num] && @grid[0][column_num] == @grid[2][column_num]
                true
            else
                false
            end
        end
    end

    def three_in_a_diagonal?
        case
        when @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2]
            cell_blank?(0, 0) || cell_blank?(1, 1) || cell_blank?(2, 2) ? false : true
        when @grid[2][0] == @grid[1][1] && @grid[2][0] == @grid[0][2]
            cell_blank?(0, 0) || cell_blank?(1, 1) || cell_blank?(2, 2) ? false : true
        else
          false
        end
    end    
end

game_one = Game.new
