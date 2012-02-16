module CanTango::PermitStore
  class Permit
    class Rules
      # can and cannot rules for a single permit (or permit mode)
      attr_accessor :static, :compiled

      def initialize rules = {}
        @static   = rules[:static]
        @compiled = rules[:compiled]
      end
      # {:can => {:edit => ['Project]}}
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
end