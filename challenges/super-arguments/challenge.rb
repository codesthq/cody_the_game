class Parent
  def foo
    "Hello"
  end
end

class Child < Parent
  def foo(name)
    super + " #{name}!"
  end
end

puts Child.new.foo("John")
