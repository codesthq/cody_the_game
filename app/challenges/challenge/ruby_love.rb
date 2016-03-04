# There is "ruby_love" method:
#
# def ruby_love
#   We ♥ Ruby! What about you?
# end
#
# Write a code to return from this method "I ♥ Ruby too!" string without changing it.

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
