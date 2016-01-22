def array
  ["def", "ruby", "do", "if", "end"]
end

def response_formatter(finder)
  puts "First two character element in array is \"#{finder.call}\""
end

def greeter
  puts "Hello"

  finder = Proc.new { array.each { |element| return element if element.length == 2} }

  response_formatter(finder)
end

greeter

# change body of method greeter so it always return message:
# Hello
# First two character element in array is "X"
# Where X is first two letter string in array
