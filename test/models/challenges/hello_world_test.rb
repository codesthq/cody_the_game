require 'test_helper'

class HelloWorldTest < ActiveSupport::TestCase
  test "returning true for proper answer" do
    code = "puts 'Hello World!'"
    challenge = Challenge::HelloWorld.new(code)
    assert challenge.run
  end

  test "returning false for wrong answer" do
    code = "puts 'Hello World'"
    challenge = Challenge::HelloWorld.new(code)
    assert_equal false, challenge.run
  end

  test "returning false for syntax error in code" do
    code = "puts 'Hello World"
    challenge = Challenge::HelloWorld.new(code)
    assert_equal false, challenge.run
  end

  test "returning false for exceptions" do
    code = "nil + 3"
    challenge = Challenge::HelloWorld.new(code)
    assert_equal false, challenge.run
  end
end
