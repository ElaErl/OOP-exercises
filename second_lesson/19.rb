Now create a smart name= method that can take just a first name or a full name, 
and knows how to set the first_name and last_name appropriately.

class Person
  def initialize(firs
    @name = name
    @name.split(' ').size > 1 ? 
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