module CanTango::PermitStore::Parser
  class PermitMode
    attr_reader :name, :mode, :rules

    def initialize name, mode, rules 
      @name, @mode, @rules = [name, mode, rules]
    end

    #   no_cache:
    #     can:
    #       edit: [Project, Post]
    #   cache:
    #     cannot:
    #       publish: Project      
    #
    def parse &block
      # puts "PermitMode#parse #{rules}"
      rules.each do |type, rule|
        # puts "PermitMode#parse #{type}, #{rule}"
        add_rule type, rule
      end
      yield permit if block
      permit
    end

    protected

    def add_rule type, rule
      permit_mode.static_rules.send :"#{type}=", rule
    end

    def permit_mode
      permit.for_mode(mode)
    end
    
    def permit
      @permit ||= CanTango::PermitStore::Permit.new name
    end
  end
end
