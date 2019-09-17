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
