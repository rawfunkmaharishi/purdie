require 'active_support/inflector'

class Thing
  def hello
    puts "I am a #{self.class.name}"
  end
end

t = "Thing".constantize.new
t.hello
