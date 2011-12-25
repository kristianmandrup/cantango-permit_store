module CanTango::PermitStore::Load
  class Rules
    attr_accessor :static_rules, :compiled_rules

    def initialize rules
      @static_rules = rules
    end
    
    def static_rules
      @static_rules ||= Hashie::Mash.new
    end

    def compiled_rules
      @compiled_rules ||= Hashie::Mash.new
    end
    
    def compiled_rules
      compile_rules!
      @compiled_rules
    end

    def compile_rules!
      compiler.compile! self
      @compiled_rules = compiler.to_hashie
    end

    def compiler
      @compiler ||= CanTango::PermitStore::Compiler.new
    end    
  end
end