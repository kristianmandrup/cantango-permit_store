module CanTango::PermitStore::Permit
  class Rules
    attr_accessor :static_rules, :compiled_rules

    def initialize rules = {}
      @static_rules   = rules[:static_rules]
      @compiled_rules = rules[:compiled_rules]
    end
    
    def to_hash
      {:static_rules => static_rules, :compiled_rules => compiled_rules}
    end
    
    def static_rules
      @static_rules ||= Hashie::Mash.new
    end
    
    def compiled_rules
      @compiled_rules ||= compiler.to_hashie
    end

    def compiler
      @compiler ||= CanTango::PermitStore::Compiler.new self
    end    
  end
end