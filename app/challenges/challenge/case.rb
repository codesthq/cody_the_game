# any_object = []
#
# case any_object
# when ~:foo
#   # any_object responds to :foo method
# when ~:size
#   # any_object responds to :size method
# else
# end
#
# Implement a code that allows to use ~:foo syntax in 'case' statement.

module Challenge
  class Case < TaskRunner::BaseTask
    def test_case
      result = run_user_code <<-CODE.strip_heredoc
        <INCLUDE_USER_CODE>;

        object1 = Object.new
        def object1.funny_method
        end

        case object1
        when ~:foo
        when ~:funny_method
          puts "funny_method branch"
        else
        end

        object2 = Object.new
        case object2
        when ~:foo
        else
          puts "else branch"
        end
      CODE

      result.success? && result.stdout == "funny_method branch\nelse branch"
    end
  end
end
