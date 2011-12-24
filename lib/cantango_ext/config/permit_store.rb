module CanTango
  module Config
    class PermitStore < Engine
      include CanTango::Config::Factory

      def type_options
        {:type => default_type}
      end

      def default_type= type
        raise ArgumentError, "Must be a String or Symbol, was #{type}" if !type.kind_of_label?
        @default_type = type.to_sym
      end

      def default_type
        @default_type || :memory
      end
    end
  end
end