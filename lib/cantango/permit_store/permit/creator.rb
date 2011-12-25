module CanTango::PermitStore::Permit
  class Creator
    # rules is a Hashie, a Hash where keys can also be accessed as method calls
    attr_accessor :permit

    def initialize permit
      @permit = permit
    end

    delegate :mode, :rules, :type, :name, :to => :permit
    
    def create
      permit_class.add_rules(mode, rules)
    end
    
    def permit_class
      return registered_class if registered_class
      create_permit_class
    end
    
    def create_permit_class
      Object.const_set(class_name, Class.new do 
        def add_rules mode, rules
          mode_rules[name] = rules
        end
                
        def mode_rules
          @mode_rules ||= {}
        end
      end      
    end
    
    protected
    
    def class_name
      "CanTango::Permit::#{type.to_s.camelize}::#{name.to_s.camelize}"
    end
    
    def registered_class
      CanTango.config.permits.registered_for(type, name)
    end
  end
end