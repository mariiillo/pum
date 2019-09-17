require "pum/version"
require "pum/configure"

module Pum
  ParamNotFound = Class.new(StandardError)

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def call(param)
      new(param).call
    end
  end

  private def initialize(param)
    raise ParamNotFound if param.nil?

    @param = param
  end
end
