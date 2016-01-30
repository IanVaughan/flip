# Uses :default option passed to feature declaration.
# May be boolean or a Proc to be passed the definition.
module Flip
  class DeclarationStrategy < AbstractStrategy
    def description
      "The default status declared with the feature."
    end

    def knows? definition
      !definition.options[:default].nil?
    end

    def on?(definition, param = false)
      default = definition.options[:default]
      default.is_a?(Proc) ? default.call(param) : default
    end
  end
end
