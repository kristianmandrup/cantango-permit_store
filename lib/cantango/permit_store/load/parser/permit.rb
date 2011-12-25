module CanTango::PermitStore::Load::Parser
  class Permit
    attr_reader :permit, :rules

    def initialize permit, rules 
      @permit, @rules = [permit, rules]
    end

    # set :can and :cannot on permit with the permit rule
    def parse &blk
      # Forget keys because I don't know what to do with them
      rules.each do |type, rule|
        rule_error!(type) unless valid_rule?(type)
        permit.static_rules.send :"#{type}=", rule
      end
    end

    def valid_rule? type
      valid_rule_types.include?(type.to_sym)
    end

    def valid_rule_types
      [:can, :cannot]
    end
      
    def rule_error! type
      raise ArgumentError, error_msg(type)
    end
    
    def error_msg(type)
      "CanTango permit store valid rule keys #{valid_rule_types}, was: #{type}"
    end
  end
end