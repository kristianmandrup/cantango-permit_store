module CanTango::PermitStore::Loader
  class Permits
    attr_reader :type, :permits_hash
    
    def initialize type, permits_hash
      @type, @permits_hash = [type, permits_hash]
    end
    
    protected

    def load
      permits_hash.each do |key, rules|
        parser(rules).parse do |permit|
          permits[type][permit.name] = permit
        end
      end
    end

    def permits
      @permits ||= Hashie::Mash.new
    end

    def parser rules
      @parser ||= CanTango::PermitStore::Parser::Permits.new rules
    end        
  end
end
