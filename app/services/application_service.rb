class ApplicationService
  class << self
    def call(args)
      new(**args).call
    end
  end

  def call
    raise NotImplementedError
  end
end
