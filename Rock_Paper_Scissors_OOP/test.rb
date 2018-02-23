class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']

  SHORTHAND_VALUES = {
    'r' => 'rock',
    'p' => 'paper',
    'sc' => 'scissors',
    'sp' => 'spock',
    'l' => 'lizard'
  }

  WINNING_MOVES = {
    'rock' => ['scissors', 'lizard'],
    'paper' => ['rock', 'spock'],
    'scissors' => ['paper', 'lizard'],
    'spock' => ['rock', 'scissors'],
    'lizard' => ['paper', 'spock']
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    WINNING_MOVES[@value].include?(other_move.to_s)
  end

  def <(other_move)
    WINNING_MOVES[other_move.to_s].include?(@value)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :move_history
  attr_reader :score

  def initialize
    @score = 0
    set_name
    @move_history = []
  end

  def increment_score
    @score += 1
  end

  def to_s
    @name
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose_move
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (sc)issors, (l)izard, or (Sp)ock: "
      choice = gets.chomp.strip.downcase
      break if Move::VALUES.include?(choice)
      if Move::SHORTHAND_VALUES[choice]
        choice = Move::SHORTHAND_VALUES[choice]
        break
      end
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
    move_history.push(move)
  end
end

class Computer < Player # Chooses move randomly
  def set_name
    self.name = self.class.name
  end

  def choose_move
    self.move = Move.new(Move::VALUES.sample)
    move_history.push(move)
  end
end

class R2D2 < Computer # Chooses only rock
  def choose_move
    self.move = Move.new('rock')
    move_history.push(move)
  end
end

class Hal < Computer # Chooses scissors a lot and rock a little
  def choose_move
    self.move = Move.new(['scissors', 'scissors', 'scissors', 'rock'].sample)
    move_history.push(move)
  end
end

# Game Orchestration Engine
class RPSGame
  SCORE_TO_WIN = 3

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [Computer.new, Hal.new, R2D2.new].sample
  end

  def clear_screen
    system('clear') || system('clr')
  end

  def display_welcome_message
    clear_screen
    puts "Hi, #{human}!"
    puts "Welcome to #{Move::VALUES.join(', ')}. First to #{SCORE_TO_WIN} wins!"
    puts "Press Enter to continue."
    gets.chomp
  end

  def display_goodbye_message
    puts ""
    puts "Thanks for playing #{Move::VALUES.join(', ')}. Goodbye!"
  end

  def display_moves
    puts ""
    puts "#{human} chose #{human.move}"
    puts "#{computer} chose #{computer.move}"
    puts ""
  end

  def display_round_winner
    if human.move > computer.move
      puts "#{human} won the round!"
    elsif human.move < computer.move
      puts "#{computer} won the round!"
    else
      puts "It's a tie!"
    end
  end

  def display_move_history
    puts "#{human} choices: #{human.move_history.join(', ')}"
    puts "#{computer} choices: #{computer.move_history.join(', ')}"
  end

  def update_score
    if human.move > computer.move
      human.increment_score
    elsif human.move < computer.move
      computer.increment_score
    end
  end

  def overall_winner?
    computer.score == SCORE_TO_WIN || human.score == SCORE_TO_WIN
  end

  def choose_moves
    human.choose_move
    computer.choose_move
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def display_overall_score
    puts "Scores: | #{human}: #{human.score} | #{computer}: #{computer.score} |"
  end

  def display_overall_winner
    winner = human.score == SCORE_TO_WIN ? human : computer
    puts ""
    puts "#{winner} reached #{SCORE_TO_WIN} points and is the winner!"
    puts ""
  end

  def play_round
    clear_screen
    display_overall_score
    choose_moves
    display_moves
    display_round_winner
    update_score
  end

  def play
    display_welcome_message
    loop do
      play_round
      break if overall_winner? || !play_again?
    end
    clear_screen unless overall_winner?
    display_overall_score
    display_overall_winner if overall_winner?
    display_move_history
    display_goodbye_message
  end
end

RPSGame.new.play