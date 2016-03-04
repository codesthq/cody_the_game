# For the code:
#
# object = Object.new
# change_object(object)
#
# def empty?(o)
#   o.size == 0
# end
#
# implement a method 'change_object' so it will modify given object in a way that calling empty?(object) returns "Hello World" string.

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
