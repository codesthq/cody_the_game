class SampleTask < TaskRunner::BaseTask
  NAME = "SFSDDS"
  DESCRIPTION = "SFSSD"

  def test_puts_hello_word
    result = run_user_code("<INCLUDE_USER_CODE>")
    result.success? && result.stdout == "Hello World!"
  end

  def test_runtime_error
    result = run_user_code("sdafsa; <INCLUDE_USER_CODE>")
    !result.success?
  end

  def test_stdrerr
    result = run_user_code("sdafsa; <INCLUDE_USER_CODE>")
    result.stderr.include?("NameError: undefined")
  end
end
