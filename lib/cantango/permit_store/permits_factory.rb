module CanTango::PermitStore
  class PermitsFactory
    include CanTango::Helpers::Debug

    attr_accessor :ability

    # creates the factory for the ability
    # note that the ability contains the roles and role groups of the user (or account)
    # @param [Permits::Ability] the ability
    def initialize ability
      @ability = ability
    end

    def build!
      debug "Building permits"
      @evaluators ||= types.inject([]) do |res, type|
        res << collector(type).build
        res
      end.flatten.compact
    end

    def collector(type)
      rules = store.send(type)
      ns::Collector.new(ability, rules, type)
    end

    delegate :options, :to => :ability

    def store
      store_class.new :permits, store_options
    end

    def store_class
      store.default_class
    end

    def store_options
      store.options.merge(:path => config_path)
    end

    delegate :types, :config_path, :store, :to => :permit_store

    private

    def ns
      CanTango::PermitStore::Execute
    end

    def permit_store
      CanTango.config.engine(:permit_store)
    end
  end
end