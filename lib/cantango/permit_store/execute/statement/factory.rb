module CanTango::PermitStore::Execute::Statement
  class Factory
    attr_accessor :rules, :method, :actions
    
    def initialize rules, method, actions
      @rules, @method, @actions = [rules, method, actions]
    end
    
    def targets
      rules.static.send(method).send(:[], action.to_s)
    end
    
    # Example: can([:edit, :manage], [Article, Comment])
    def statements_string
     targets ? create_statements.to_code : nil
    end

    def create_statements
      CanTango::Engine::Permission::Statements.new method, actions, targets
    end
  end
end