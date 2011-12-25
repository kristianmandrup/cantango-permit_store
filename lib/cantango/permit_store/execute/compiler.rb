module CanTango::PermitStore::Execute
  class Compiler
    attr_reader :permit, :categories

    def initialize
    end

    def compile! permit
      @permit = permit
      self
    end

    def to_hashie
      Hashie::Mash.new eval_statements
    end

    def eval_statements
      {:can => can_eval, :cannot => cannot_eval}
    end

    def can_eval &block
      build_statements :can, &block
    end

    def cannot_eval &block
      build_statements :cannot, &block
    end

    protected

    # build the 'can' or 'cannot' statements to evaluate
    def build_statements method, &block
      return nil if !permit.static_rules.send(method)
      yield statements(method) if !statements(method).empty? && block
      statements(method)
    end
    
    def check_actions method
      raise "valid actions are: #{valid_actions}" if invalid_actions?(permit_actions_for method)
    end

    def permit_actions_for method
      permit.static_rules.send(method).keys.to_symbols
    end

    def invalid_actions? permit_actions
      (permit_actions - valid_actions).size > 0
    end

    def statements method
      check_actions method
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