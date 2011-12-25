module CanTango::PermitStore::Load
  module Parser
    class Permits

      def initialize
      end

      def parse(key, obj, &blk)
        permit = create_permit key
        case obj
        when Hash
          parse_permit(obj, permit, &blk)
        else
          raise "Each key must have a YAML hash that defines its permission configuration"
        end
        yield permit if blk
      end

      protected

      def create_permit key
        CanTango::PermitStore::Load::Permit.new key
      end

      # set :can and :cannot on permit with the permit rule
      def parse_permit(obj, permit, &blk)
        # Forget keys because I don't know what to do with them
        obj.each do |key, value|
          key_error! unless valid_key(key)
          permit.static_rules.send :"#{key}=", value
        end
      end

      def valid_key? key
        [:can, :cannot].include?(key.to_sym)
      end
      
      def key_error!
        raise ArgumentError, "A CanTango permit store .yml file can only have the keys can: and cannot:"
      end 
    end
  end
end
