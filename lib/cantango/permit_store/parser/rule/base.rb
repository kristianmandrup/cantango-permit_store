module CanTango::PermitStore::Parser::Rule
  class Base
    attr_reader :method, :action, :model, :target

    def initialize method, action, target
      @target = target
      @method = method
      @action = action
    end

    def parse
      raise NotImplementedError
    end

    def parse_class target = nil
      @target = target if target
      try_class.to_s
    end

    def try_class
      target.constantize
    rescue
      raise "[permission] target #{target} does not have a class so it was skipped"
    end
  end
end