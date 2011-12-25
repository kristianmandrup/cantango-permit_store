module CanTango::PermitStore::Execute::Statement
  class Single
    attr_accessor :method, :actions, :conditions

    def initialize method, actions, conditions = {}
      @method, @actions, @conditions = [method, conditions]
      @actions = [actions].flatten
    end

    def to_code
      conditions.empty? ? simple_statement : full_statement
    end
    
    def simple_statement
      "#{method}(#{actions.inspect})"
    end

    def full_statement
      "#{method}(#{actions.inspect}, #{conditions})"
    end
  end
end
