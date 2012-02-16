module CanTango::PermitStore::Loader
  class Hash
    attr_reader :hash
    
    def initialize hash
      @hash = hash
    end

    def load
      return if hash.empty?
      hash.each do |type, permits_hash|
        next if permits_hash.empty?
        permits_of(type).merge! permits_loader(type, permits_hash).load
      end
      permits
    end

    protected

    def permits_of type
      permits[type] = {}
    end

    def permits
      @permits ||= Hashie::Mash.new
    end
    
    def permits_loader type, permits_hash
      CanTango::PermitStore::Loader::Permits.new type, permits_hash
    end
  end
end