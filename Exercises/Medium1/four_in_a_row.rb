class Board
  attr_accessor :board
  def initialize
    @board = {}
    initial_board
  end

  def initial_board
    7.times do |ind|
      @board[ind + 1] = []
    end
  end

  def draw
    puts
    puts "=> You are X, Computer is O <="
    puts
    puts " #{board[1][5] || " "} | #{board[2][5] || " "} | #{board[3][5] || " "} | #{board[4][5] || " "} | #{board[5][5] || " "} | #{board[6][5] || " "} | #{board[7][5] || " "}"
    puts "---------------------------"
    puts " #{board[1][4] || " "} | #{board[2][4] || " "} | #{board[3][4] || " "} | #{board[4][4] || " "} | #{board[5][4] || " "} | #{board[6][4] || " "} | #{board[7][4] || " "}"
    puts "---------------------------"
    puts " #{board[1][3] || " "} | #{board[2][3] || " "} | #{board[3][3] || " "} | #{board[4][3] || " "} | #{board[5][3] || " "} | #{board[6][3] || " "} | #{board[7][3] || " "}"
    puts "---------------------------"
    puts " #{board[1][2] || " "} | #{board[2][2] || " "} | #{board[3][2] || " "} | #{board[4][2] || " "} | #{board[5][2] || " "} | #{board[6][2] || " "} | #{board[7][2] || " "}"
    puts "---------------------------"
    puts " #{board[1][1] || " "} | #{board[2][1] || " "} | #{board[3][1] || " "} | #{board[4][1] || " "} | #{board[5][1] || " "} | #{board[6][1] || " "} | #{board[7][1] || " "}"
    puts "---------------------------"
    puts " #{board[1][0] || " "} | #{board[2][0] || " "} | #{board[3][0] || " "} | #{board[4][0] || " "} | #{board[5][0] || " "} | #{board[6][0] || " "} | #{board[7][0] || " "}"
    puts
    puts "==========================="
    puts " 1 | 2 | 3 | 4 | 5 | 6 | 7 "
    puts "==========================="
  end

  def lines
    arr = []
    new_arr = []
    count = 0

    7.times do |num|
      arr << column(num + 1)
    end

    loop do
      new_arr << []
      arr.each do |subar|
        new_arr[count] << subar[count]
      end
      count += 1
      break if count > 5
    end

    new_arr
  end

  def column(num_of_col)
    @board[num_of_col]
  end

  def column_full?(num_of_col)
    @board[num_of_col].size > 5
  end

  def empty_columns
    empty_columns = []
    @board.each do |col, arr|
      if arr.size < 6
        empty_columns << col
      end
    end
    empty_columns
  end
        
  def full?
    @board.values.all? {|arr| arr.size > 5}
  end

end

class Player
  USER_MARKER = 'X'
  COMP_MARKER = "O"
  attr_accessor :user_move, :comp_move, :board, :win
  def initialize(board)
    @board = board
  end

  def lines_won(mark)
    a = false
    board.lines.each do |line|
      line.each_with_index do |marker, ind|
        if ind < 4 && 
          marker == mark && 
          line[ind + 1] == mark && 
          line[ind + 2] == mark && 
          line[ind + 3] == mark
          a = true
        end
      end
    end
    a  
  end

  def diagonals_won(mark)
    a = nil
    board.lines[3..5].each_with_index do |line, line_index|
      line.each_with_index do |marker, ind|
        left = (board.lines[line_index + 2][ind + 1] == mark) &&
               (board.lines[line_index + 1][ind + 2] == mark) &&
               (board.lines[line_index][ind + 3] == mark)
        right = (board.lines[line_index + 2][ind - 1] == mark) &&
                (board.lines[line_index + 1][ind - 2] == mark) &&
                (board.lines[line_index][ind - 3] == mark)
        if (marker == mark && ind < 3) && left
           a = true
           break
        elsif (marker == mark && ind == 3) && (left || right)
           a = true
           break
        elsif (marker == mark && ind > 3) && right
           a = true
           break
        end
      end
    end
    a == true
  end

  def columns_won(mark)
    count = []
    counter = 1
    loop do
      @board.column(counter).each_with_index do |n, ind|
        count << ind if n == mark
      end 

      if @board.column(counter).count(mark) >= 4 &&
       (count.max - count.min) == 3
         board.draw
         return true
      else
        count.clear
        counter += 1
        return false if counter == 8
      end
    end
  end
end


class User < Player
  def user_move
    choice = nil
    loop do
      puts
      puts "Please pick a colum #{board.empty_columns}"
      puts
      choice = gets.chomp.to_i
      puts
      break if (1..7).to_a.include?(choice) && !board.column_full?(choice)
      puts "Sorry, not a valid choice"
      puts
    end
    board.column(choice) << USER_MARKER
  end

  def user_win?
    columns_won(USER_MARKER) || lines_won(USER_MARKER) || diagonals_won(USER_MARKER)
  end
end

class Computer < Player
  def comp_move
    choice = board.empty_columns.sample
    board.column(choice.to_i) << COMP_MARKER
  end

  def comp_win?
    columns_won(COMP_MARKER) || lines_won(COMP_MARKER) || diagonals_won(COMP_MARKER)
  end
end
  
class Game
  attr_reader :comp, :user, :board
  def initialize
    @board = Board.new
    @comp = Computer.new(@board)
    @user = User.new(@board)
  end

  def play
    display_welcome_msg
    loop do
      @board.draw
      @user.user_move
      break if board.full? || user.user_win? || comp.comp_win?
      @comp.comp_move
      break if board.full? || user.user_win? || comp.comp_win?
    end
    display_result
    display_goodbye_msg
  end

  def display_result
    @board.draw
    if board.full?
      puts
      puts "The board is full - it's a tie!"
    elsif user.user_win?
      puts
      puts "Congrats, you won!"
    else
      puts
      puts "Computer won, better luck next time!"
    end
  end

  def display_welcome_msg
    puts
    puts "*** Welcome to 4 in a row! ***"
    puts
  end

  def display_goodbye_msg
    puts
    puts "*** Thanks for playing. We hope you enjoyed the game! ***"
    puts
  end
end

a = Game.new
a.play
