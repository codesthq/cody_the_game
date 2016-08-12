require 'trusted_sandbox'

module TaskRunner
  class BaseTask
    attr_reader :user_code

    def initialize(user_code)
      @user_code = user_code
    end

    def run_user_code(runner_code_template)
      runner_code = runner_code_template.gsub("<INCLUDE_USER_CODE>") { user_code }

      result = TrustedSandbox.run_code runner_code

      stderr = (result.status == "error" ? result.error.inspect : result.stderr.first.try(:chomp) )
      Response.new(result.status, result.stdout.first.try(:chop), stderr)
    end

    def run
      get_test_methods.all? do |test_method|
        send(test_method)
      end
    end

    private

    def get_test_methods
      all_methods = (self.methods - Object.methods)
      all_methods.select { |method_name| method_name.to_s[/^test_/] }
    end
  end
end
