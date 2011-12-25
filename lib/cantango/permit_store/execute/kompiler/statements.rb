module CanTango::PermitStore::Execute
  class Kompiler
    module Statements    
      # build the 'can' or 'cannot' statements to evaluate
      def build_statements method, &block
        return nil unless permit_statements?
        yield statements(method) if statements?(method) && block
        statements(method)
      end

      def permit_statements?
        permit.statements(:static).send(method)
      end

      # employs caching
      def statements method
        check_actions method
        @method_statements[method] ||= create_statements method
      end
    
      def create_statements method
        ns::StatementsBuilder.new permit, method, actions
      end
    
      def statements? method
        !statements(method).empty?
      end

      def invalid_actions? permit_actions
        (permit_actions - valid_actions).size > 0
      end

      def method_statements
        @method_statements ||= {}
      end

      def check_actions method
        raise "valid actions are: #{valid_actions}" if invalid_actions?(permit_actions_for method)
      end

      def permit_actions_for method
        permit.static_rules.send(method).keys.to_symbols
      end
      
      def ns
        CanTango::PermitStore::Execute::Kompiler
      end
    end
  end
end