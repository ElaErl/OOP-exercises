class Person
  attr_accessor :first_name, :last_name
  def initialize(first_name, last_name = "")
    @first_name = first_name
    @last_name = last_name
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(nam)
    @first_name = nam.split.first
    @last_name = nam.split.size < 2 ? "" : nam.split.last
    @name = nam
  end

end


bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'