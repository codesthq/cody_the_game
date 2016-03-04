# Re-implement nodule operator it in that way following code will work properly:
# 
# 10 % 3 #=> 1
# 23 % 0 # raises ZeroDivisionError error
#
# Don't worry about negative numbers.

module Challenge
  class Modulo < TaskRunner::BaseTask
    def test_modulo
      result = run_user_code <<-CODE.strip_heredoc
        Numeric.send(:remove_method, :divmod)
        Numeric.send(:remove_method, :modulo)
        Numeric.send(:remove_method, :%)

        Fixnum.send(:remove_method, :divmod)
        Fixnum.send(:remove_method, :modulo)
        Fixnum.send(:remove_method, :%)

        ;<INCLUDE_USER_CODE>;

        puts [1 % 784, 999 % 3, 1023 % 1024, 0 % 452167, 5362178 % 5678, begin; 123 % 0; rescue ZeroDivisionError; "ZeroDivisionError"; end].join(",")
      CODE

      result.success? && result.stdout == "1,0,1023,0,2146,ZeroDivisionError"
    end
  end
end
