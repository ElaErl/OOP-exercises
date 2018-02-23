# Using the following code, create a class named Cat that 
# prints a greeting when #greet is invoked. 
# The greeting should include the name and color of the cat. Use a constant to define the color.

# class Cat
#   COLOR = "purple"
#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{@name} and I'm a #{COLOR} cat!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

# Expected output:

# Hello! My name is Sophie and I'm a purple cat!

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "I'm #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# puts kitty

# Using the following code, create a class named Person with an instance variable named @secret. 
# Use a setter method to add a value to @secret, then use a getter method to print @secret.

# class Person
#   attr_accessor :secret
# end

# person1 = Person.new
# person1.secret = 'Shh.. this is a secret!'
# puts person1.secret

# Expected output:

# Shh.. this is a secret!

Using the following code, add a method named share_secret that prints the value of @secret when invoked.

class Person
  attr_writer :secret
  
  def share_secret
    puts @secret
  end
  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret
