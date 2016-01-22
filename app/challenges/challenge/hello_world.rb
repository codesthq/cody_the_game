# Challenge: write a program which prints "Hello World!" on the screen.

module Challenge
  class HelloWorld < TaskRunner::BaseTask
    def test_hello_world
      result = run_user_code("<INCLUDE_USER_CODE>")
      result.success? && result.stdout == "Hello World!"
    end
  end
end