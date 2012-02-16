module CanTango::PermitStore::Loader
  # The Permits loader takes a hash in the form of
  # user:
  #   admin:
  #     can:
  #       read: Article
  #   editor:
  #     cache:
  #       cannot:
  #         manage: Article
  #         publish: Article
  # 
  # Thus this loader can load all the permits of a certain type
  # 
  class Permits
    attr_reader :type, :permits_hash
    
    def initialize type, permits_hash
      @type, @permits_hash = [type, permits_hash]
    end

    # loads all the permits of a certain type from a Hash
    # each Hash for a permit is parsed using a Permit Parser
    # the resulting permits are stored in a Hash called permits, keyed by name of permit
    def load
      permits_hash.each do |name, permit_rules|
        permit_parser(name, permit_rules).parse do |permit|
          permits[name] = permit
        end
      end
      permits
    end

    protected

    # the loaded (parsed) permits are stored in a Mash (Hash)
    def permits
      @permits ||= Hashie::Mash.new
    end

    # Parses a single Permit from a hash
    def permit_parser name, permit_rules
      @permit_parser ||= CanTango::PermitStore::Parser::Permit.new name, permit_rules
    end        
  end
end
