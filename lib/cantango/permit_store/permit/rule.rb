module CanTango::PermitStore
  class Permit
    class Rule
      attr_accessor :type

      def initialize
      end

      def content
        @content ||= Hashie::Mash.new
      end
    
      def to_code
        raise NotImplementedError
      end
    end
  end
end