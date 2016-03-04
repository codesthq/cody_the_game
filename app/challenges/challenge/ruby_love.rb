# Challenge

# Here is the funny method I wrote once:
#
# def ruby_love
#   We ♥ Ruby! What about you?
# end
#
# This method should return "I ♥ Ruby too!" string. You can't change 'ruby_love' method at all.

module Challenge
  class RubyLove < TaskRunner::BaseTask
    def test_ruby_love
      result = run_user_code <<-CODE.strip_heredoc
        ;<INCLUDE_USER_CODE>;

        def ruby_love
          We ♥ Ruby! What about you?
        end

        puts ruby_love
        puts "OUR SUFFIX"
      CODE

      stdout = result.stdout
      stdout.force_encoding("utf-8")
      result.success? && stdout == "I ♥ Ruby too!\nOUR SUFFIX"
    end
  end
end
