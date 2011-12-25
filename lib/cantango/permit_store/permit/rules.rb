module CanTango::PermitStore::Permit
  class Rules
    attr_accessor :static, :compiled

    def initialize rules = {}
      @static   = rules[:static]
      @compiled = rules[:compiled]
    end
    
    def to_hash
      { :static => static, :compiled => compiled }
    end
        
    def static
      @static ||= Hashie::Mash.new
    end
    
    def compiled
      @compiled ||= compiler.to_hashie
    end

    def compiler
      @compiler ||= CanTango::PermitStore::Execute::Compiler.new self
    end    
  end
end