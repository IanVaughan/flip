module Flip
  module Facade
    def on?(feature, param = nil)
      FeatureSet.instance.on?(feature, param)
    end

    def reset
      FeatureSet.reset
    end

    def method_missing(method, *parameters)
      super unless method =~ %r{^(.*)\?$}
      FeatureSet.instance.on?($1.to_sym, parameters.first)
    end
  end
end
