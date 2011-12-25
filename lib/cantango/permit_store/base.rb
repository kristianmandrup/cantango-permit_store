module CanTango  
  module PermitStore
    class Base
      attr_reader :name, :options

      include CanTango::Helpers::Debug

      def initialize name, options = {}
        @name, @options = [name, options]
        set_attributes options
      end

      def load!
        raise NotImplementedError
      end

      def save! permits
        debug "No permits to save" unless permits
      end
      
      protected

      def set_attributes options = {}
        options.each_pair do |name, value|
          var = :"@#{name}"
          self.instance_variable_set(var, value)
        end
      end
    end
  end
end
