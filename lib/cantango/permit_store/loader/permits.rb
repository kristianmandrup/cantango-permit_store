module CanTango::PermitStore::Loader
  class Permits
    attr_reader :type, :permits_hash
    
    def initialize type, permits_hash
      @type, @permits_hash = [type, permits_hash]
      permits[type] ||= {}
    end
    
    def load
      permits_hash.each do |name, rules|
        parser(name, rules).parse do |permit|
          permits[type][permit.name] = permit
        end
      end
      permits
    end

    protected

    # the loded permits are stored in a Mash (Hash)
    def permits
      @permits ||= Hashie::Mash.new
    end

    def parser name, rules
      @parser ||= CanTango::PermitStore::Parser::Permits.new name, rules
    end        
  end
end
