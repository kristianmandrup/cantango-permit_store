module CanTango::PermitStore::Load
  class Collector
    include CanTango::Helpers::Debug

    attr_reader :ability, :permits, :type

    def initialize ability, permits, type
      debug "Collecting #{type} permits"
      @ability = ability
      @permits = permits
      @type = type
    end

    def build
      relevant_rules.inject([]){|evaluators, (name, rules)|
        evaluators << CanTango::PermitStore::Evaluator.new(ability, rules) 
      }
    end

    def relevant_rules
      selector.select permits
    end

    def selector
      CanTango::PermitStore::Selector.create type, self
    end

    def user
      ability.user
    end

    def user_account
      ability.user_account
    end
    alias_method :account, :user_account

    def user_key_field
      ability.user_key_field
    end
  end
end