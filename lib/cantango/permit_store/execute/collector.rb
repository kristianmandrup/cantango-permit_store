module CanTango::PermitStore::Execute
  class Collector
    include CanTango::Helpers::Debug

    attr_reader :ability, :permits, :type

    delegate :user, :user_key_field, :account, :to => :ability

    def initialize ability, permits, type
      debug "Collecting #{type} permits"
      @ability = ability
      @permits = permits
      @type = type
    end

    def build
      relevant_rules.inject([]) do |evaluators, (name, rules)|
        evaluators << ns::Evaluator.new(ability, rules) 
      end
    end

    def relevant_rules
      selector.select permits
    end

    protected

    def selector
      ns::Selector.create type, self
    end
    
    def ns
      CanTango::PermitStore::Execute
    end
  end
end