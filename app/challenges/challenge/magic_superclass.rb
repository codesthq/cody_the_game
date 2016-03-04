# Implement a MagicSuperclass class which won't allow to add new methods to subclasses.
#
# class Subclass < MagicSuperclass
#   def some_method
#   end
# end
#
# o = Subclass.new
# o.respond_to?(:object_id)   #=> true
# o.object_id                 #=> 70366278078900 (inherited methods work)
# o.respond_to?(:some_method) #=> true
# o.some_method               #=> NoMethodError

module Challenge
  class MagicSuperclass < TaskRunner::BaseTask
    def test_superclass
      result = run_user_code <<-CODE.strip_heredoc
        ;<INCLUDE_USER_CODE>;

        class MyFunnyClass < MagicSuperclass
          def foo
            "MyFunnyClass#foo called"
          end
        end

        class MyOtherClass
          def foo
            "MyOtherClass#foo called"
          end
        end

        funny    = MyFunnyClass.new
        ordinary = MyOtherClass.new

        puts [(funny.foo rescue "MyFunnyClass#foo NoMethodError"), funny.class.name, funny.nil?,  ordinary.foo].join(",")
      CODE

      result.success? && result.stdout == "MyFunnyClass#foo NoMethodError,MyFunnyClass,false,MyOtherClass#foo called"
    end
  end
end
