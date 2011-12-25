module CanTango::PermitStore::Execute::Compiler
  class StatementsBuilder
    attr_reader :permit, :method, :actions
    
    def initialize permit, method, actions
      @permit, @method, @actions = [permit, method, actions]
    end
    
    def build method      
      valid_actions.map do |actions|
        statements_factory(method, actions).statements_string
      end.compact.join("\n")
    end

    def statements_factory
      CanTango::PermitStore::Execute::Statement::Factory.new permit, method, actions
    end

    def valid_actions
      [:manage, :read, :update, :create, :write]
    end
  end
end