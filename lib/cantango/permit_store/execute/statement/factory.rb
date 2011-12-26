module CanTango::PermitStore::Execute::Statement
  class Factory
    attr_accessor :rules
    
    def initialize rules
      @rules = rules
    end

    def methods
      rules.keys
    end

    def actions_for key
      rules[key].keys
    end

    # Example: can([:edit, :manage], [Article, Comment])
    def statements_string
     targets ? create_statements.to_code : nil
    end

    def create_statements
      CanTango::Engine::Permission::Statement::Multi.new rules
    end
  end
end