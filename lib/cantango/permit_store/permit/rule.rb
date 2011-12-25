module CanTango::PermitStore::Permit
  class Rule
    attr_accessor :can, :cannot

    def initialize
    end

    [:can, :cannot].each do |meth|
      class_eval %{
        def #{meth}
          @#{meth} ||= Hashie::Mash.new
        end
      }
    end
    
    def to_code
      
    end
  end
end