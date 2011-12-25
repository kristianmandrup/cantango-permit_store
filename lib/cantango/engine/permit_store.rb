module CanTango
  module Engine
    class PermitStore < Base
      # include CanTango::Ability::Executor
      include CanTango::Ability::Helper::User

      def initialize ability
        super
      end

      def permit_rules
        permits.each do |permit|
          permits.evaluate! user
        end
      end

      def engine_name
        :permit_store
      end

      def valid?
        return false if !valid_mode?
        permits.empty? ? invalid : true
      end

      def permissions
        permit_factory.build!
      end

      protected

      alias_method :cache_key, :engine_name

      def start_execute
        debug "Permission Engine executing..."
      end

      def end_execute
        debug "Done PermitStore Engine"
      end

      def invalid
        debug "No permits found!"
        false
      end

      def permit_factory
        @permit_factory ||= CanTango::PermitStore::Factory.new self
      end

      def changed?
        permit_factory.store.changed?
      end
    end
  end
end