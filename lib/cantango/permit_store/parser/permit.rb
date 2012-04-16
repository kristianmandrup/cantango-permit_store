module CanTango::PermitStore::Parser
  class Permit
    attr_reader :name, :permit_rules
    attr_writer :mode

    def initialize name, permit_rules
      @name, @permit_rules = [name, permit_rules]
    end

    # Parses for a Hash of the form:
    # cache:
    #   can:
    #     edit: [Project, Post]
    #   cannot:
    #     publish: Project      
    # no_cache:
    #
    # this parser will delegate to a Permit mode parser
    
    def parse &block
      # Forget keys because I don't know what to do with them
      permit_rules.each do |type, rules|
        add_permit parse_permit(type, rules, &block)
      end
    end

    def add_permit permit
      permit_creator(permit).create
    end

    protected

    def parse_permit type, rules, &block
      build_mode_parser(type, rules).parse
    end

    def build_mode_parser type, rules
      return mode_parser(type, rules) if valid_mode? type
      return mode_parser(:default, rules) if valid_rule_type? type
      rule_type_error!(type)
    end

    def mode_parser mode, rules
      @mode_parser ||= CanTango::PermitStore::Parser::PermitMode.new name, mode, rules
    end

    def permit_creator permit
      CanTango::PermitStore::Permit::Creator.new permit
    end

    def valid_type? type
      valid_rule_type?(type) || valid_mode?(type) 
    end

    def valid_mode? type
      valid_modes.include?(type.to_sym)
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