module CanTango::PermitStore::Permit
  class Rule
    attr_accessor :type

    def initialize
    end

    def content
      @content ||= Hashie::Mash.new
    end
    
    def to_code
      "#{type}
    end
  end
end