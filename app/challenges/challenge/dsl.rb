# Implement class Squirrel in a way below API will be supported.
#
# squirrel = Squirrel.new
#
# squirrel.fight do
#   jump
#   kick
#   punch
#   jump
# end
#
# squirrel.actions #=> ["jump", "kick", "punch", "jump"]

module Challenge
  class Dsl < TaskRunner::BaseTask
    def test_conditional
      result = run_user_code <<-CODE.strip_heredoc
        <INCLUDE_USER_CODE>;

        squirrel_inner = nil
        squirrel_outer = Squirrel.new
        squirrel_outer.fight do
          kick
          jump

          squirrel_inner = Squirrel.new
          squirrel_inner.fight do
            punch
            jump
            kick
          end

          punch
          jump
          punch
        end

        puts squirrel_outer.actions.join(",")
        puts squirrel_inner.actions.join(",")
      CODE

      result.success? && result.stdout == "kick,jump,punch,jump,punch\npunch,jump,kick"
    end
  end
end
