module CanTango
  autoload_modules :YamlPermitStore, :MonetaPermitStore
  
  class PermitStore
    autoload_modules :Collector, :Compiler, :Evaluator, :Selector
    autoload_modules :Factory, :Loader, :Parser, :Permission
    autoload_modules :RulesParser, :Store, :Statements, :Statement

    attr_reader :name, :options

    def initialize name, options = {}
      @name, @options = [name, options]

      options.each_pair do |name, value|
        var = :"@#{name}"
        self.instance_variable_set(var, value)
      end
    end

    def load!
      raise NotImplementedError
    end

    def save! permissions
      raise NotImplementedError
    end
  end
end
