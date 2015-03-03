class Thing
  def hello
    puts "I am a #{self.class.name}"
  end
end

Thing.new.hello

t = "Thing"
