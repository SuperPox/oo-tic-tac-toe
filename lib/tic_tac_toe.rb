require 'pry'
class TicTacToe
    attr_accessor :winnerToken, :board
    #attr_reader :board 
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," ",]
        @winnerToken = ""
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "------------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "------------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def move(index,token = "X")
        board[index] = token
    end

    def input_to_index(string) # sends a 1
        int = string.to_i
        int = int - 1  # becomes 0
     end

    def position_taken?(index)
        if self.board[index] == "X"
            true
        elsif self.board[index] == "O"
            true
        else
            false
        end
    end

    def valid_move?(index)
        # true if the move is valid and false or nil if not
        if (index.between?(0, 8) == true) && (self.position_taken?(index) == false)
            return true
        else
            return false
        end
    end

    def turn_count
        self.board.find_all{|i| i == "X" || i == "O"}.length
    end

    def current_player
        #uses turn_count to decide if it's X or O's turn
        if self.turn_count.odd? == true
            return "O"
        else
            return "X"
        end
    end

    def turn
        puts "Please enter a number (1-9):"
        input = gets.strip #"1"     
        index = input_to_index(input) #where we want to play // send it to index method
        if valid_move?(index) 
            xORo = current_player
            move(index, xORo)
            display_board
        else
            turn  
        end    
    end
    
    # 0 1 2
    # 3 4 5
    # 6 7 8
    #          0         1         2             3           4          5            6           7
    # => [[0, 1, 2], [3, 4, 5], [6, 7, 8],   [0, 3, 6], [1, 4, 7], [2, 5, 8],   [0, 4, 8], [2, 4, 6]]
    # => ["X", "O", "X", 
    #     "O", "X", "X", DRAW
    #     "O", "X", "O"]
    #                    ["X", "O", "X", "O", "X", "X", "O", "X", "O"]

    #    ["X", "O", "X", 
    #     "O", "X", "O",  Win by set 6 [0, 4, 8]
    #      O", "X", "X"]
    # as an array:       [!!"X"!!, "O", "X", "O", !!"X"!!, "O", "O", "X", !!"X"!!]
    
    def won?
        # use wincombinations
        # turn board into same numbers?
        WIN_COMBINATIONS.each_with_index do |combo|
            if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X"
                @winnerToken = "X"
                return combo
            elsif
                board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O" 
                @winnerToken = "O"
                return combo #flatten?        
            end
        end
        return false
    end
        
        
    def full?
        int = board.find_all{|i| i == "X" || i == "O"}.length 
        if int == 9
            return true
        else
            return false
        end
    end

    def draw?
        if ((self.full? == true) && (self.won? == false))
            return true
        else
            return false
        end
        
        # int = self.board.find_all{|i| i == "X" || i == "O"}.length 
        # if ((int == 9) && self.won? == false)
        #     return true
        # else
        #     return false
        # end
    end

    def over?  
        self.full? || self.won? || self.draw?
        # int = self.board.find_all{|i| i == "X" || i == "O"}.length 
        # if int == 9
        #     return true
        # elsif self.won? == true
        #     return true
        # elsif self.draw? == true # added
        #     return true        
        # else 
        #     return false
        # end
    end

    def winner
        self.won?
        #binding.pry  #[1] pry(#<TicTacToe>)> @winner => "X"
        if @winnerToken == "X"
            #binding.pry #[1] pry(#<TicTacToe>)> puts "#@winner" X => nil
            @winnerToken #spec: expect(game.winner).to eq("X")
        elsif @winnerToken == "O"
            #puts "O"
            #puts @winner.to_s
            @winnerToken
        else
            return nil
        end
    end

    # uncommenting below blows up the spec
    
    def play 
        until self.over? 
            self.turn
        end
            ####
        if self.won?           
            puts "Congratulations #{self.winner}!" #to receive(:puts).with("Congratulations X!")
        else
            puts "Cat's Game!"
        end
    end
end
