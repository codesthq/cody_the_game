# Write a Ruby program that prints sentence "Ruby was released in 1995!" on the screen
# by using only small letters, big letters, dots, spaces and new lines.

module Challenge
  class RubyWasReleased < TaskRunner::BaseTask
    def test_contains_only_allowed_characters
      user_code =~ /\A[a-zA-Z. \n]*\z/
    end

    def test_output_message
      result = run_user_code("<INCLUDE_USER_CODE>")
      result.success? && result.stdout == "Ruby was released in 1995!"
    end
  end
end
