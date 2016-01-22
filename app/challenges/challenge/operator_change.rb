# Challenge: write a method 'change_object'

# Your task is to implement it in such a way that following code:
# object = Object.new
# change_object(object)
#
# def empty?(o)
#   o.size == 0
# end
#
# puts empty?(o)
# would print 'Hello World!' on the screen

module Challenge
  class OperatorChange < TaskRunner::BaseTask
    def test_operator_change
      result = run_user_code <<-CODE.strip_heredoc
        <INCLUDE_USER_CODE>;

        object = Object.new
        change_object(object)

        def empty?(o)
          o.size == 0
        end

        puts empty?(object)
        puts "OUR SUFFIX"
      CODE

      result.success? && result.stdout == "Hello World!\nOUR SUFFIX"
    end
  end
end
