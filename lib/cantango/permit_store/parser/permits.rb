module CanTango::PermitStore::Parser
  class Permits
    attr_reader :type_permit, :rules

    def initialize type_permit, rules
      @type_permit, @rules = [type_permit, rules]
    end

    # user_type:
    #   user:
    #     can:    
    #   admin:      
    def parse &block
      yield permit(&block) if block
    end

    protected

    def permit &block
      error! unless type_permit.kind_of?(Hash)
      parser.parse(&block)
    end

    def parser
      CanTango::PermitStore::Parser::Permit.new rules 
    end
      
    def error!
      raise "Each key must have a YAML hash that defines its permission configuration"        
    end
  end
end
