# Challenge: implement your own Array#find_all method

# I removed find_all from Array class!
# Your task is to implement your own Array#find_all method so
# [1, 2, 3, 4].find_all { |e| e > 2 } would return [3, 4].

module Challenge
  class FindAll < TaskRunner::BaseTask
    def test_find_all
      result = run_user_code <<-CODE.strip_heredoc
        Enumerable.send(:remove_method, :find_all);
        <INCLUDE_USER_CODE>;

        puts [*1..20].find_all { |e| e == 1 || (e >= 10 && e <= 13) || e == 19 }.join(",")
      CODE

      result.success? && result.stdout == "1,10,11,12,13,19"
    end
  end
end
