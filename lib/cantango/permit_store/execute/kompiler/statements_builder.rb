module CanTango::PermitStore::Execute
  class Kompiler
    class StatementsBuilder
      attr_reader :rules, :method, :actions
    
      def initialize rules, method, actions
        @rules, @method, @actions = [rules, method, actions]
      end
    
      def build method      
        valid_actions.map do |actions|
          statements_factory(method, actions).statements_string
        end.compact.join("\n")
      end

      def statements_factory
        CanTango::PermitStore::Execute::Statement::Factory.new rules, method, actions
      end

      def valid_actions
        [:manage, :read, :update, :create, :write]
      end
    end
  end
end