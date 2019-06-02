require "pry"
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    add_student_attributes(student_hash)
    @@all << self
    self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      self.new(student)
    end
    # binding.pry 
  end

  def add_student_attributes(attributes_hash)
    # https://learn.co/tracks/online-software-engineering-structured/object-oriented-ruby/metaprogramming/mass-assignment-and-metaprogramming
    # supposed to use mass asignment + metaprogramming here
    # will use the key/value pairs to assign instance variables
    # to the self
    attributes_hash.each do |key, value| 
      self.send(("#{key}="), value)
    end
    
    #thought process
    # attributes_hash.each do |student|
    #   student.each do |key, value|
    #     if key == :name
    #       @name = value
    #       elsif key == :location
    #         @location = valuel
    #       elsif key == :twitter
    #         @twitter = value
    #       elsif key == :linkedin
    #         @linkedin = value
    #       elsif key == :github
    #         @github = value
    #       elsif key == :blog
    #         @blog = value
    #       elsif key == :profile_quote
    #         @profile_quote = value
    #       elsif key == :bio
    #         @bio == value
    #       else 
    #         @profile_url = value
    #     end
    #   end
    # end
    # binding.pry
  end

  def self.all
    @@all 
  end
end

