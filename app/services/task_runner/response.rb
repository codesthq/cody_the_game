module TaskRunner
  Response = Struct.new(:status, :stdout, :stderr) do
    def success?
      status == "success"
    end
  end
end
