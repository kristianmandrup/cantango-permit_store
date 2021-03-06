module CanTango::PermitStore
  class Permit
    sweetload :Creator, :Rules, :Rules
    
    # rules is a Hashie, a Hash where keys can also be accessed as method calls
    attr_accessor :name

    def initialize name
      @name = name
    end

    def mode
      @mode ||= :no_cache
    end

    def for_mode mode
      @mode = mode
      modes[mode] = rules
    end

    def add_rule rule
      rules << rule
    end


    def rules
      @rules ||= CanTango::PermitStore::Permit::Rules.new
    end

    def modes
      @modes ||= Hashie::Mash.new
    end

    def key
      name.to_s
    end

    def to_hash
      {key => modes.to_hash}
    end
  end
end
