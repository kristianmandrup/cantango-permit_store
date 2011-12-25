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
          permits.evaluate
        end
      end

      def engine_name
        :permit_store
      end

      def valid?
        return false if !valid_mode?
        permits.empty? ? invalid : true
      end

      def permits
        permits_factory.build!
      end

      protected

      alias_method :cache_key, :engine_name

      def start_execute
        debug "PermitStore Engine executing..."
      end

      def end_execute
        debug "Done PermitStore engine"
      end

      def invalid
        debug "No permits found!"
        false
      end

      def permits_factory
        @permits_factory ||= CanTango::PermitStore::PermitsFactory.new self
      end

      def changed?
        permits_factory.store.changed?
      end
    end
  end
end