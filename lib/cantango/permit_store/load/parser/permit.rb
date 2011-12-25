module CanTango::PermitStore::Load::Parser
  class Permit
    attr_reader :permit, :rules

    def initialize permit, rules 
      @permit, @rules = [permit, rules]
    end

    # set :can and :cannot on permit with the permit rule
    #   can:
    #     edit: [Project, Post]
    #   cannot:
    #     publish: Project      
    def parse &blk
      # Forget keys because I don't know what to do with them
      rules.each do |type, rule|
        rule_type_error!(type) unless valid_rule_type?(type) || valid_mode?(type) 
        valid_mode?(type) ? parse_mode(type, rule, &blk) : add_rule(type, rule)
      end
    end

    def parse_mode mode, rules, &blk
      mode_parser.new(mode, rules).parse &blk
    end

    def mode_parser mode, rules
      CanTango::PermitStore::Load::Parser::PermitMode.new mode, rules
    end 

    def add_rule type, rule
      permit.static_rules.send :"#{type}=", rule
    end

    def valid_mode? type
      valid_modes.include?(type.to_sym)
    end

    def valid_rule_type? type
      valid_rule_types.include?(type.to_sym)
    end

    def valid_modes
      CanTango.config.ability.modes.registered
    end

    def valid_rule_types
      [:can, :cannot]
    end
      
    def rule_type_error! type
      raise ArgumentError, error_msg(type)
    end
    
    def error_msg(type)
      "CanTango permit store valid rule keys: #{valid_rule_types} or mode: #{valid_modes}, was: #{type}"
    end
  end
end