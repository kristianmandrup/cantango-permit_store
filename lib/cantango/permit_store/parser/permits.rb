module CanTango::PermitStore::Parser
  class Permits
    attr_reader :name, :rules

    def initialize name, rules
      @name, @rules = [name, rules]
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
      CanTango::PermitStore::Parser::Permit.new name, rules 
    end      
  end
end
