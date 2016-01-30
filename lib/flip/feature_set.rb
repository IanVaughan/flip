module Flip
  class FeatureSet
    def self.instance
      @instance ||= self.new
    end

    def self.reset
      @instance = nil
    end

    # Sets the default for definitions which fall through the strategies.
    # Accepts boolean or a Proc to be called.
    attr_writer :default

    def initialize
      @definitions = Hash.new { |_, k| raise "No feature declared with key #{k.inspect}" }
      @strategies = Hash.new { |_, k| raise "No strategy named #{k}" }
      @default = false
    end

    # Whether the given feature is switched on.
    def on?(key, param = nil)
      d = @definitions[key]
      @strategies.each_value { |s| return s.on?(d, param) if s.knows?(d) }
      default_for param
    end

    # Adds a feature definition to the set.
    def << definition
      @definitions[definition.key] = definition
    end

    # Adds a strategy for determing feature status.
    def add_strategy(strategy)
      strategy = strategy.new if strategy.is_a? Class
      @strategies[strategy.name] = strategy
    end

    def strategy(klass)
      @strategies[klass]
    end

    def default_for(param = nil)
      @default.is_a?(Proc) ? @default.call(param) : @default
    end

    def definitions
      @definitions.values
    end

    def strategies
      @strategies.values
    end
  end
end
