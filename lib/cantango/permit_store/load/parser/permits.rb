module CanTango::PermitStore::Load
  module Parser
    class Permits

      attr_reader :type_permit, :rules

      def initialize type_permit, rules
        @type_permit, @rules = [type_permit, rules]
      end

      def parse &blk
        case type_permit
        when Hash
          parser(rules, permit).parse &blk
        else
          raise "Each key must have a YAML hash that defines its permission configuration"
        end
        yield permit if blk
      end

      protected

      def parser
        CanTango::PermitStore::Load::Parser::Permit.new permit, rules 
      end

      def permit
        CanTango::PermitStore::Load::Permit.new type_permit
      end
    end
  end
end
