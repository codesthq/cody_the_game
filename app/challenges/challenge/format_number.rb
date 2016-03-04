# Challenge: convert number to string according to formatting rule

# Write a method called 'format_number' which converts given integer number to string like this:
# format_number(1234)    #=> "1_234"
# format_number(-1234)   #=> "-1_234"
# format_number(134567)  #=> "134_567"
# format_number(49)      #=> "49"

module Challenge
  class FormatNumber < TaskRunner::BaseTask
    def test_format
      result = run_user_code <<-CODE.strip_heredoc
        ;<INCLUDE_USER_CODE>;

        puts [0, -9, 56, 123, -7515, 333444, 43892404070705849,-983220721754].map { |e| format_number(e) }.join(",")
      CODE

      result.success? && result.stdout == "0,-9,56,123,-7_515,333_444,43_892_404_070_705_849,-983_220_721_754"
    end
  end
end
