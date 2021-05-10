# frozen_string_literal: true

class ApplicationFormatter
  Result = Struct.new(:success?, :error, :value)

  def self.call(*args)
    new(*args).call
  end

  def result(success, error, value)
    Result.new(success, error, value)
  end
end
