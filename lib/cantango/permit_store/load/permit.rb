module CanTango::PermitStore::Load
  class Permit
    # rules is a Hashie, a Hash where keys can also be accessed as method calls
    attr_accessor :name, :static_rules, :compiled_rules

    def initialize name
      @name = name
    end

    def static_rules
      @static_rules ||= Hashie::Mash.new
    end

    def compiled_rules
      @compiled_rules ||= Hashie::Mash.new
    end

    def key
      name.to_s
    end

    def to_hash
      {key => static_rules.to_hash}
    end

    def to_compiled_hash
      {key => compiled_rules}
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
