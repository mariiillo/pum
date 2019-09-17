require "pum/version"

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

module Pum
  module Configure
    extend self

    def config
      yield self
    end

    def mix_into(classes)
      classes.each do |klass|
        klass.define_method :| do |callable|
          map { |e| callable.call(e) }
        end
      end
    end
  end
end
