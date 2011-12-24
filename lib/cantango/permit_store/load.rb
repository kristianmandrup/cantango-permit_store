module CanTango
  module PermitStore
    module Load
      autoload_modules :Collector, :Compiler, :Evaluator, :Selector
      autoload_modules :Factory, :Parser, :Permit
      autoload_modules :Statements, :Statement
    end
  end
end
