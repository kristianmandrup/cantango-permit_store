module CanTango::PermitStore
  class PermitsFactory
    include CanTango::Helpers::Debug

    attr_accessor :ability

    delegate :options, :to => :ability
    delegate :types, :store, :to => :permit_store

    # creates the factory for the ability
    # note that the ability contains the roles and role groups of the user (or account)
    # @param [Permits::Ability] the ability
    def initialize ability
      @ability = ability
    end

    def build!
      debug "Building permits"
      evaluators
    end

    def evaluators
      @evaluators ||= types.inject([]) do |res, type|
        res << collector(type).build
        res
      end.flatten.compact
    end

    def collector(type)
      rules = permit_store.send(type)
      ns::Collector.new ability, rules, type
    end
    
    def ns
      CanTango::PermitStore::Execute
    end

    def permit_store
      CanTango.config.engine(:permit_store)
    end
  end
end