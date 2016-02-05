# Challenge: implement this funny syntax for conditional statement

# Writing ordinary if statement is boring. Your task is to implement this
# funny looking conditional statement.
# (1 == 1).--> { puts "true" } { puts "false" } # should print "true"
# (0 >= 1).--> { puts "true" } { puts "false" } # should print "false"
# (0 >= 1).--> { puts "true" }                  # should do nothing

module Challenge
  class ConditionalStatement < TaskRunner::BaseTask
    def test_conditional
      result = run_user_code <<-CODE.strip_heredoc
        <INCLUDE_USER_CODE>;

        (true).--> { puts "first is true" } { puts "wrong!" }
        (false).--> { puts "wrong!" } { puts "second is false" }
        (false).--> { puts "wrong!" }
      CODE

      result.success? && result.stdout == "first is true\nsecond is false"
    end
  end
end
