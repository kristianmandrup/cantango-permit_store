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
      permit_rules.each do |type, rule|
        add_permit parse_permit(type, rule, &block)
      end
    end

    def add_permit permit
      permit_creator(permit).create
    end

    protected

    def parse_permit type, rule, &block
      build_mode_parser(type, rule).parse
    end

    def build_mode_parser type, rule
      return mode_parser(type, rule) if valid_mode? type
      return mode_parser(:default, rule) if valid_rule_type? type
      rule_type_error!(type)
    end

    def mode_parser mode, rule
      @mode_parser ||= CanTango::PermitStore::Parser::PermitMode.new mode, rule
    end

    def permit_creator permit
      CanTango::PermitStore::Permit::Creator.new permit
    end

    def parse_permit &block
      mode_parser.parse &block
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