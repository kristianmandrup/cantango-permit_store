module CanTango::PermitStore::Load::Parser
  class PermitMode
    attr_reader :mode, :rules

    def initialize permit, mode, rules 
      @permit, @mode, @rules = [permit, mode, rules]
    end

    #   no_cache:
    #     can:
    #       edit: [Project, Post]
    #   cache:
    #     cannot:
    #       publish: Project      
    #
    def parse &blk
      puts "PermitMode#parse #{rules}"
      rules.each do |type, rule|
        puts "PermitMode#parse #{type}, #{rule}"

      end
    end

    def add_rule type, rule
      permit_mode.static_rules.send :"#{type}=", rule
    end

    def permit_mode
      permit.for_mode(mode)
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
