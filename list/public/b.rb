class Greeting
  def initialize(greeting)
    @greeting = greeting
  end

  def greet
    puts @greeting
  end
end

Greeting.new("Hello there").greet
