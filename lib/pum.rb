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
      yield(Pum::Setup.new)
    end
  end

  class Setup
    def mix_into(classes)
      classes.each do |klass|
        klass.define_method :| do |callable|
          map { |e| callable.call(e) }
        end
      end
    end
  end
end

Pum::Configure.config do |pum|
  pum.mix_into [Array]
end

# Example
class AddTwo
  include Pum

  def call
    @param + 2
  end

end

class AddThree
  include Pum

  def call
    @param + 3
  end
end
puts [1, 2, 3] | AddTwo | AddThree
puts [1, 2, 3] | AddTwo | AddThree
