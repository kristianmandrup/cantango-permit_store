module CanTango::PermitStore::Parser
  class Permits
    attr_reader :rules

    def initialize rules
      @rules = rules
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
      parser.parse &block
    end

    def parser
      CanTango::PermitStore::Parser::Permit.new rules 
    end      
  end
end
