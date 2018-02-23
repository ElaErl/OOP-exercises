class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def rock?
    @value == 'rock'
  end

  def spock?
    @value == 'spock'
  end

  def lizard?
    @value == 'lizard'
  end

  def >(other_move)
    (rock? && (other_move.scissors? || other_move.lizard?)) ||
      (paper? && (other_move.rock? || other_move.spock?)) ||
      (scissors? && (other_move.paper? || other_move.lizard?)) ||
      (spock? && (other_move.rock? || other_move.scissors?)) ||
      (lizard? && (other_move.paper? || other_move.spock?))
  end

  def <(other_move)
    (rock? && (other_move.paper? || other_move.spock?)) ||
      (paper? && (other_move.scissors? || other_move.lizard?)) ||
      (scissors? && (other_move.rock? || other_move.spock?)) ||
      (spock? && (other_move.lizard? || other_move.paper?)) ||
      (lizard? && (other_move.rock? || other_move.scissors?))
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter your name"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['2r2', 'sunny', 'peter', 'men', 'compy'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer
  @@comp_wins = 0
  @@human_wins = 0

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to PRS"
  end

  def display_goodbye_message
    puts "Goodbye, hope you enjoyed the game"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won"
      @@human_wins += 1
    elsif human.move < computer.move
      puts "#{computer.name} won"
      @@comp_wins += 1
    else
      puts "it's a tie"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Wanna play again (y/n)?"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Please type y or n"
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def score
    if @@comp_wins == 3
      @@comp_wins = 0
      @@human_wins = 0
      puts "The owerall victory goes to the computer."
    elsif @@human_wins == 3
      @@comp_wins = 0
      @@human_wins = 0
      puts "You are the overall winner. Congrats!"
    else
      puts "Computer has #{@@comp_wins} win"
      puts "You have #{@@human_wins} win"
    end
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      score
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play


