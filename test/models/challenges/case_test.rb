require 'test_helper'

class HelloWorldTest < ActiveSupport::TestCase
  test "returning true for proper answer" do
    code = <<-CODE.strip_heredoc
      class Symbol
        def ~
          ->(o) { o.respond_to?(self) }
        end
      end
    CODE

    challenge = Challenge::Case.new(code)
    assert challenge.run
  end
end
