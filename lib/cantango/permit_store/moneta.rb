require 'moneta'
require 'active_support/inflector'

module CanTango
  module PermitStore
    class Moneta < Base
      # one cache store is shared for all store instances (w different names)

      # for a YamlStore, the name is the name of the yml file
      def initialize name, options = {}
        super        
        store.configure_with options
      end

      def store
        CanTango::Cache::MonetaCache.instance
      end

      def self.create name, options = {}
        super
      end

      def load!
        store.load! name
      end

      def store permissions
        store.save! name, permissions.map {|p| p.to_a }
      end
    end
  end
end