module CanTango::PermitStore::Execute::Statement
  class Factory
    attr_accessor :permit, :method, :actions
    
    def initialize permit, method, actions
      @permit, @method, @actions = [permit, method, actions]
    end
    
    def targets
      permit.static_rules.send(method).send(:[], action.to_s)
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