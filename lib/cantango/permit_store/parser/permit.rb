module CanTango::PermitStore::Parser
  class Permit
    attr_reader :name, :rules

    def initialize name, rules 
      @name, @rules = [name, rules]
    end

    # set :can and :cannot on permit with the permit rule
    #   can:
    #     edit: [Project, Post]
    #   cannot:
    #     publish: Project      
    def parse &block
      # Forget keys because I don't know what to do with them
      rules.each do |type, rule|
        rule_type_error!(type) unless valid_rule_type?(type) || valid_mode?(type) 
        add_permit permit(type, rule, &block)
      end
    end

    def add_permit permit
      permit_creator.new(permit).create
    end

    protected

    def permit_creator
      CanTango::PermitStore::Load::PermitCreator
    end

    def permit type, rules, &blk
      mode_parser.new(type, rules).parse &blk
    end

    def valid_mode? type
      valid_modes.include?(type.to_sym)
    end

    def mode_parser mode, rules
      CanTango::PermitStore::Load::Parser::PermitMode.new name, mode, rules
    end

    def valid_modes
      CanTango.config.ability.modes.registered
    end

    def valid_rule_type? type
      valid_rule_types.include?(type.to_sym)
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