module CanTango::PermitStore::Execute::Statement
  class Single
    attr_accessor :method, :actions, :conditions

    def initialize method, actions, conditions = {}
      @method, @actions, @conditions = [method, actions, conditions]
    end

    def to_code
      conditions.empty? ? simple_statement : full_statement
    end
    
    def simple_statement
      "#{method}(:#{actions})"
    end

    def full_statement
      "#{method}(:#{actions}, #{conditions})"
    end
  end
end
