module CanTango::PermitStore
  module Parser
    sweetload :Permits, :Permit, :PermitMode, :Rule

    def self.create_for meth, action, target
      parser_class(target).new method, action, target
    end

    protected

    def self.parser_class target
      parser_name(target).constantize
    end

    def self.parser_name target      
      "#{ns}::#{parser_type(target).to_s.camelize}"
    end
    
    def self.ns
      "CanTango::PermitStore::Parser::Rule"
    end

    def self.parser_type target
      case target.to_s
      when /\/(.*)\//
        :regex
      when /^\^(\w+)/ # a category is prefixed with a '^<D-^>s'
        :category
      when /\w+#\w+=.+/
        :relationship
      when /\w+#\w+/
        :ownership
      else
        :default
      end
    end
  end
end