module CanTango::PermitStore::Load
  module Parser
    class Default < Rule
      def parse
        return default_all if target == 'all'
        parse_class target
        "#{method}(:#{action}, #{target})"
      end

      def default_all
        "#{method}(:#{action}, :all)"
      end
    end
  end
end