class User
  attr_accessor :num_of_guesses, :guess
  def initialize
    @num_of_guesses = 7
    @guess = ""
  end

  def looses
    @num_of_guesses == 0
  end

  def beats(computer)
    @guess == (computer).guess
  end
end

class Computer
  attr_accessor :guess
  def initialize
    @guess = (1..100).to_a.sample
  end
end

class GuessingGame
  attr_accessor :user, :computer

  def initialize
    @user = User.new
    @computer = Computer.new
  end

  def play
    loop do
      puts "You have #{user.num_of_guesses} remaining guesses"
        loop do
          puts "Enter a number between 1 and 100"
          user.guess = gets.chomp.to_i
          break if valid_choice
          puts "Invalid guess"
        end
      break if user.beats(computer) or user.looses
      user.num_of_guesses -= 1
      puts weight_guess
    end
    puts final_result
  end

  def valid_choice
    (1..100).include?(user.guess)
  end

  def final_result
    user.looses ? "You are out of guesses. You lose." : "You win"
  end

  def weight_guess
    user.guess < computer.guess ? "Your guess is too low" : "Your guess is too high"
  end
end

game = GuessingGame.new
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# You win!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low
# You are out of guesses. You lose.